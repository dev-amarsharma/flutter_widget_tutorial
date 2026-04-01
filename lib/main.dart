import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'models/app_config.dart';
import 'screens/performance_screen.dart';
import 'services/app_config_service.dart';
import 'services/interstitial_ad_service.dart';
import 'services/performance_service.dart';
import 'widget_catalog_page.dart';
import 'widget_preview_page.dart';
import 'widgets/banner_ad_widget.dart';
import 'widgets/custom_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await performanceService.init();
  await appConfigService.loadConfig();
  await MobileAds.instance.initialize();

  final requestConfiguration = RequestConfiguration(
    testDeviceIds: ['B4B7D2919335B10A2648BC0F5DF2296C'],
  );
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  await interstitialAdService.loadInterstitialAd();

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

class _MyHomePageState extends State<MyHomePage> {
  Set<String> _readAssets = {};

  @override
  void initState() {
    super.initState();
    _readAssets = performanceService.readAssets;
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PerformanceScreen(),
              ),
            );
          },
          child: const Icon(Icons.bar_chart),
          tooltip: 'My Performance',
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
