import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/app_config.dart';
import 'screens/performance_screen.dart';
import 'services/app_config_service.dart';
import 'services/app_open_ad_service.dart';
import 'services/app_share_service.dart';
import 'services/consent_service.dart';
import 'services/interstitial_ad_service.dart';
import 'services/performance_service.dart';
import 'services/purchase_service.dart';
import 'widget_catalog_page.dart';
import 'widget_preview_page.dart';
import 'widgets/banner_ad_widget.dart';
import 'widgets/custom_dialog.dart';
import 'widgets/expandable_fab.dart';

/// Devices that receive test ads (and the UMP debug geography) in debug builds.
const List<String> kAdTestDeviceIds = ['B4B7D2919335B10A2648BC0F5DF2296C'];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock the app to portrait orientation only.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await performanceService.init();
  await appConfigService.loadConfig();
  await purchaseService.init();
  await MobileAds.instance.initialize();

  final requestConfiguration = RequestConfiguration(
    testDeviceIds: kAdTestDeviceIds,
  );
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  // Read the cached UMP consent state. This is a local read, so startup is not
  // held up by the network; the fresh update runs from the home screen.
  await consentService.refresh();

  // Only preload ads when the user hasn't purchased "Remove Ads" and consent
  // allows ad requests.
  if (!purchaseService.adsRemoved.value && consentService.canRequestAds.value) {
    await interstitialAdService.loadInterstitialAd();

    // Pre-load the App Open ad during startup so it is ready on first resume.
    appOpenAdService.loadAd();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppConfig config = appConfigService.config;
    final theme = config.theme;

    return MaterialApp(
      title: config.materialAppTitle,
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: theme.primary,
          onPrimary: theme.onPrimary,
          secondary: theme.secondary,
          onSecondary: theme.onSecondary,
          error: Colors.red,
          onError: Colors.white,
          background: theme.background,
          onBackground: theme.onBackground,
          surface: theme.surface,
          onSurface: theme.onSurface,
        ),
        scaffoldBackgroundColor: theme.background,
        appBarTheme: AppBarTheme(
          backgroundColor: theme.primary,
          foregroundColor: theme.onPrimary,
          iconTheme: IconThemeData(color: theme.onPrimary),
          titleTextStyle: TextStyle(
            color: theme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: theme.onBackground),
          bodyMedium: TextStyle(color: theme.onBackground),
          bodySmall: TextStyle(color: theme.secondary),
        ),
        dividerColor: theme.surface,
        cardColor: theme.primary,
        iconTheme: IconThemeData(color: theme.icon),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: theme.fabBackground,
          foregroundColor: theme.fabForeground,
        ),
      ),
      home: MyHomePage(title: config.catalogTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  Set<String> _readAssets = {};

  @override
  void initState() {
    super.initState();
    _readAssets = performanceService.readAssets;
    WidgetsBinding.instance.addObserver(this);
    // Try to show the App Open ad once the first frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) appOpenAdService.showAdIfAvailable();
      _refreshConsentAndAds();
    });
  }

  /// Refreshes the UMP consent info, shows the consent form when the user's
  /// region requires one, and (re)starts ad preloading once consent allows it.
  Future<void> _refreshConsentAndAds() async {
    await consentService.init(testDeviceIds: kAdTestDeviceIds);
    await consentService.showFormIfRequired();
    if (!mounted) return;
    if (purchaseService.adsRemoved.value) return;
    if (!consentService.canRequestAds.value) return;

    // Consent may have arrived only now, so the startup preloads were skipped.
    interstitialAdService.loadInterstitialAd();
    await appOpenAdService.loadAd();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      appOpenAdService.showAdIfAvailable();
    }
  }

  /// Bottom sheet offering the one-time "Remove Ads" purchase and restore.
  Future<void> _showRemoveAdsSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.block, size: 48, color: Colors.deepOrange),
            const SizedBox(height: 12),
            Text(
              'Remove All Ads',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enjoy an ad-free experience with a one-time purchase. '
              'Banners, interstitials, and app-open ads will be removed.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  Navigator.of(sheetContext).pop();
                  // The billing sheet backgrounds the app; suppress App Open.
                  appOpenAdService.suppressNextResume();
                  final ok = await purchaseService.buyRemoveAds();
                  if (!ok && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Purchase is unavailable right now. Please try again later.',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Remove Ads'),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(sheetContext).pop();
                appOpenAdService.suppressNextResume();
                await purchaseService.restorePurchases();
              },
              child: const Text('Restore Purchase'),
            ),
          ],
        ),
      ),
    );
  }

  /// Confirms before clearing all "read" history, then refreshes the list.
  Future<void> _confirmAndClearHistory(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => CustomDialog(
        title: 'Clear read history?',
        message:
            'This will clear all saved "read" marks. This action cannot be undone.',
        icon: Icons.delete_outline,
        iconColor: Colors.deepOrange,
        primaryButtonText: 'Clear',
        onPrimaryPressed: () => Navigator.of(dialogContext).pop(true),
        secondaryButtonText: 'Cancel',
        onSecondaryPressed: () => Navigator.of(dialogContext).pop(false),
      ),
    );

    if (confirmed == true) {
      await performanceService.clearAll();
      if (mounted) {
        setState(() {
          _readAssets = performanceService.readAssets;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => CustomDialog(
            title: 'Exit App?',
            message: 'Are you sure you want to close ${widget.title}?',
            icon: Icons.exit_to_app_rounded,
            iconColor: Colors.deepOrange,
            primaryButtonText: 'Exit',
            onPrimaryPressed: () => Navigator.of(context).pop(true),
            secondaryButtonText: 'Cancel',
            onSecondaryPressed: () => Navigator.of(context).pop(false),
          ),
        );

        return shouldExit ?? false;
      },
      child: Scaffold(
        floatingActionButton: ValueListenableBuilder<bool>(
          valueListenable: purchaseService.adsRemoved,
          builder: (context, adsRemoved, _) => ValueListenableBuilder<bool>(
            valueListenable: consentService.privacyOptionsRequired,
            builder: (context, privacyOptionsRequired, __) => ExpandableFab(
              distance: 128,
              actions: [
                ExpandableFabAction(
                  icon: const Icon(Icons.bar_chart),
                  tooltip: 'My Performance',
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PerformanceScreen(),
                    ),
                  ),
                ),
                if (!adsRemoved)
                  ExpandableFabAction(
                    icon: const Icon(Icons.block),
                    tooltip: 'Remove all ads',
                    onPressed: () => _showRemoveAdsSheet(context),
                  ),
                ExpandableFabAction(
                  icon: const Icon(Icons.share),
                  tooltip: 'Share app',
                  onPressed: () => appShareService.shareApp(context),
                ),
                ExpandableFabAction(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Clear read history',
                  onPressed: () => _confirmAndClearHistory(context),
                ),
                ExpandableFabAction(
                  icon: const Icon(Icons.apps),
                  tooltip: 'More apps',
                  onPressed: () {
                    // Opening an external page backgrounds the app; suppress
                    // the App Open ad on the resume that follows.
                    appOpenAdService.suppressNextResume();
                    launchUrl(
                      Uri.parse('https://mantraandsloka.web.app/'),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
                // GDPR requires a persistent entry point back to the consent
                // choices wherever the UMP says one is needed.
                if (privacyOptionsRequired)
                  ExpandableFabAction(
                    icon: const Icon(Icons.privacy_tip_outlined),
                    tooltip: 'Privacy options',
                    onPressed: () {
                      appOpenAdService.suppressNextResume();
                      consentService.showPrivacyOptionsForm();
                    },
                  ),
                // Debug-only: verify mediation adapters (incl. Meta Audience
                // Network) with the Google Mobile Ads Ad Inspector.
                if (kDebugMode)
                  ExpandableFabAction(
                    icon: const Icon(Icons.travel_explore),
                    tooltip: 'Ad inspector',
                    onPressed: () {
                      appOpenAdService.suppressNextResume();
                      MobileAds.instance.openAdInspector((error) {
                        if (error != null) {
                          debugPrint('Ad inspector error: ${error.message}');
                        }
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const SafeArea(
          top: false,
          child: BannerAdWidget(),
        ),
        body: Column(
          children: [
            Expanded(
              child: WidgetCatalogPage(
                onOpenWidget: (item) async {
                  await interstitialAdService.handleWidgetPageNavigation();
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => WidgetPreviewPage(
                        assetPath: item.assetPath,
                        quizAssetPath: item.quizAssetPath,
                        topicId: item.topicId,
                        title: item.name,
                        onMarkAsRead: (path, {topicId}) {
                          performanceService.markAsRead(
                            path,
                            topicId: topicId,
                          );
                          setState(() {
                            _readAssets = performanceService.readAssets;
                          });
                        },
                      ),
                    ),
                  );
                },
                onClear: () async {
                  await performanceService.clearAll();
                  setState(() {
                    _readAssets = performanceService.readAssets;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
