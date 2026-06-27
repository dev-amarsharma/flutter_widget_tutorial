import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/app_config.dart';
import 'screens/onboarding_screen.dart';
import 'screens/performance_screen.dart';
import 'services/achievement_service.dart';
import 'services/analytics_service.dart';
import 'services/app_config_service.dart';
import 'services/app_open_ad_service.dart';
import 'services/app_share_service.dart';
import 'services/daily_challenge_service.dart';
import 'services/interstitial_ad_service.dart';
import 'services/notification_service.dart';
import 'services/performance_service.dart';
import 'services/purchase_service.dart';
import 'services/theme_service.dart';
import 'widget_catalog_page.dart';
import 'widget_preview_page.dart';
import 'widgets/banner_ad_widget.dart';
import 'widgets/custom_dialog.dart';
import 'widgets/expandable_fab.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock the app to portrait orientation only.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await performanceService.init();
  await achievementService.init();
  await dailyChallengeService.init();
  await appConfigService.loadConfig();
  await themeService.init();
  await purchaseService.init();

  try {
    await Firebase.initializeApp();
    analyticsService.init(FirebaseAnalytics.instance);
    await notificationService.init();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } catch (_) {
    // Firebase not configured yet — analytics, notifications, and crash reporting will be silently skipped.
  }

  await MobileAds.instance.initialize();

  final requestConfiguration = RequestConfiguration(
    testDeviceIds: ['B4B7D2919335B10A2648BC0F5DF2296C'],
  );
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  await interstitialAdService.loadInterstitialAd();

  // Pre-load App Open ad during startup so it is ready on first resume.
  appOpenAdService.loadAd();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _buildThemeData(AppThemeConfig t, Brightness brightness) {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: t.primary,
        onPrimary: t.onPrimary,
        secondary: t.secondary,
        onSecondary: t.onSecondary,
        error: Colors.red,
        onError: Colors.white,
        background: t.background,
        onBackground: t.onBackground,
        surface: t.surface,
        onSurface: t.onSurface,
      ),
      scaffoldBackgroundColor: t.background,
      appBarTheme: AppBarTheme(
        backgroundColor: t.primary,
        foregroundColor: t.onPrimary,
        iconTheme: IconThemeData(color: t.onPrimary),
        titleTextStyle: TextStyle(
          color: t.onPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: t.onBackground),
        bodyMedium: TextStyle(color: t.onBackground),
        bodySmall: TextStyle(color: t.secondary),
      ),
      dividerColor: t.surface,
      cardColor: t.primary,
      iconTheme: IconThemeData(color: t.icon),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: t.fabBackground,
        foregroundColor: t.fabForeground,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppConfig config = appConfigService.config;

    return ListenableBuilder(
      listenable: themeService.themeMode,
      builder: (context, _) {
        return MaterialApp(
          title: config.materialAppTitle,
          themeMode: themeService.themeMode.value,
          theme: _buildThemeData(config.theme, Brightness.light),
          darkTheme: _buildThemeData(config.darkTheme, Brightness.dark),
          home: MyHomePage(title: config.catalogTitle),
        );
      },
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
  Future<void> _showNotificationSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _NotificationSettingsSheet(),
    );
  }

  Future<void> _showRemoveAdsSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder:
          (_) => Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 20),
                const Icon(Icons.block, size: 48, color: Colors.deepOrange),
                const SizedBox(height: 12),
                const Text(
                  'Remove All Ads',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enjoy an ad-free experience with a one-time purchase. '
                  'No subscriptions, no renewals.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      final ok = await purchaseService.buyRemoveAds();
                      if (!ok && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Purchase unavailable. Please try again later.',
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Remove Ads',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await purchaseService.restorePurchases();
                  },
                  child: const Text('Restore Purchase'),
                ),
              ],
            ),
          ),
    );
  }

  Future<void> _clearAllProgress() async {
    await performanceService.clearAll();
    await achievementService.clearAll();
    await dailyChallengeService.clearAll();
    if (mounted) setState(() {});
  }

  Future<void> _confirmAndClearHistory(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (dialogContext) => CustomDialog(
            title: 'Clear History?',
            message:
                'This will clear all saved "read" marks and your scroll position. This action cannot be undone.',
            icon: Icons.delete_forever_rounded,
            iconColor: Colors.red,
            primaryButtonText: 'Clear',
            onPrimaryPressed: () => Navigator.of(dialogContext).pop(true),
            secondaryButtonText: 'Cancel',
            onSecondaryPressed: () => Navigator.of(dialogContext).pop(false),
          ),
    );
    if (confirm == true) await _clearAllProgress();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      final seen = prefs.getBool(seenOnboardingKey) ?? false;
      if (!seen && mounted) {
        final nav = Navigator.of(context);
        await nav.push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => const OnboardingScreen(),
          ),
        );
      }
      if (mounted) appOpenAdService.showAdIfAvailable();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      appOpenAdService.showAdIfAvailable();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog<bool>(
          context: context,
          builder:
              (context) => CustomDialog(
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
          builder:
              (context, adsRemoved, _) => ExpandableFab(
                distance: 128,
                actions: [
                  ExpandableFabAction(
                    icon: const Icon(Icons.bar_chart),
                    tooltip: 'My Performance',
                    onPressed:
                        () => Navigator.of(context).push(
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
                    icon: Icon(
                      notificationService.isDailyReminderEnabled
                          ? Icons.notifications_active
                          : Icons.notifications_none,
                    ),
                    tooltip:
                        notificationService.isDailyReminderEnabled
                            ? 'Daily reminder on'
                            : 'Set daily reminder',
                    onPressed: () async {
                      await _showNotificationSheet(context);
                      if (mounted) setState(() {});
                    },
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
                    onPressed: () => launchUrl(
                      Uri.parse('https://mantraandsloka.web.app/'),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                ],
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
                      builder:
                          (_) => WidgetPreviewPage(
                            assetPath: item.assetPath,
                            quizAssetPath: item.quizAssetPath,
                            topicId: item.topicId,
                            title: item.name,
                            onMarkAsRead: (path, {topicId}) {
                              performanceService.markAsRead(
                                path,
                                topicId: topicId,
                              );
                              setState(() {});
                            },
                          ),
                    ),
                  );
                },
                onClear: () => _clearAllProgress(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationSettingsSheet extends StatefulWidget {
  @override
  State<_NotificationSettingsSheet> createState() =>
      _NotificationSettingsSheetState();
}

class _NotificationSettingsSheetState
    extends State<_NotificationSettingsSheet> {
  late bool _enabled;
  late int _hour;
  late int _minute;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _enabled = notificationService.isDailyReminderEnabled;
    _hour = notificationService.reminderHour;
    _minute = notificationService.reminderMinute;
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    await notificationService.setDailyReminder(
      enabled: _enabled,
      hour: _hour,
      minute: _minute,
    );
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _hour, minute: _minute),
    );
    if (picked != null) {
      setState(() {
        _hour = picked.hour;
        _minute = picked.minute;
      });
    }
  }

  String _formatTime() {
    final h = _hour % 12 == 0 ? 12 : _hour % 12;
    final m = _minute.toString().padLeft(2, '0');
    final period = _hour < 12 ? 'AM' : 'PM';
    return '$h:$m $period';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 20),
          const Icon(
            Icons.notifications_active,
            size: 48,
            color: Color(0xFF7C3AED),
          ),
          const SizedBox(height: 12),
          const Text(
            'Daily Learning Reminder',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Get a daily nudge to keep your learning streak going.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Enable daily reminder',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            value: _enabled,
            activeThumbColor: const Color(0xFF7C3AED),
            onChanged: (value) => setState(() => _enabled = value),
          ),
          if (_enabled) ...[
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Reminder time',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(_formatTime()),
              trailing: TextButton(
                onPressed: _pickTime,
                child: const Text('Change'),
              ),
            ),
          ],
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _saving ? null : _save,
              child:
                  _saving
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                      : const Text('Save', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
