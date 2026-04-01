import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'screens/performance_screen.dart';
import 'services/interstitial_ad_service.dart';
import 'services/performance_service.dart';
import 'widget_catalog_page.dart';
import 'widget_preview_page.dart';
import 'widgets/banner_ad_widget.dart';
import 'widgets/custom_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Performance Service
  await performanceService.init();

  // Initialize Mobile Ads SDK
  await MobileAds.instance.initialize();
  
  // Configure test device IDs for testing
  final RequestConfiguration requestConfiguration = RequestConfiguration(
    testDeviceIds: ['B4B7D2919335B10A2648BC0F5DF2296C'],
  );
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  
  // Initialize and preload interstitial ad
  await interstitialAdService.loadInterstitialAd();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Custom color palette
    const goldust = Color(0xFFFF8C00); // Dark Orange
    const brown = Color(0xFF795548);
    const gray = Color(0xFFBDBDBD);
    const black = Colors.black;
    const white = Colors.white;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: goldust,
          onPrimary: black,
          secondary: brown,
          onSecondary: white,
          error: Colors.red,
          onError: white,
          background: white,
          onBackground: black,
          surface: gray,
          onSurface: black,
        ),
        scaffoldBackgroundColor: white,
        appBarTheme: const AppBarTheme(
          backgroundColor: goldust,
          foregroundColor: black,
          iconTheme: IconThemeData(color: black),
          titleTextStyle: TextStyle(
            color: black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: black),
          bodyMedium: TextStyle(color: black),
          bodySmall: TextStyle(color: brown),
        ),
        dividerColor: gray,
        cardColor: goldust,
        iconTheme: const IconThemeData(color: brown),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: brown,
          foregroundColor: white,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Learning Catalog'),
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
            message: 'Are you sure you want to close the application?',
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
                )
            ),
          ],
        ),
      ),
    );
  }
}
