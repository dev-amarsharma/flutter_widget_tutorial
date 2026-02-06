import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

/// Service class for managing interstitial ads
class InterstitialAdService {
  static const String _interstitialAdUnitId = 'ca-app-pub-7287011693739626/7763734432';
  static const String _navigationCountKey = 'widget_page_navigation_count';
  
  InterstitialAd? _interstitialAd;
  bool _isLoading = false;
  bool _isAdReady = false;

  // Ad unit ID getter - returns actual ad unit ID
  // For testing, you can temporarily replace with test IDs:
  // Android: 'ca-app-pub-3940256099942544/1033173712'
  // iOS: 'ca-app-pub-3940256099942544/4411468910'
  static String get interstitialAdUnitId {
    // In debug mode, you might want to use test ad unit IDs
    if (kDebugMode) {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/1033173712';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/4411468910';
      }
    }
    return _interstitialAdUnitId;
  }

  /// Load an interstitial ad
  Future<void> loadInterstitialAd() async {
    if (_isLoading || _isAdReady) {
      return;
    }

    _isLoading = true;

    await InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAdReady = true;
          _isLoading = false;

          // Set full screen content callback
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;
              _isAdReady = false;
              // Load a new ad after the current one is dismissed
              loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _interstitialAd = null;
              _isAdReady = false;
              _isLoading = false;
              // Load a new ad after failure
              loadInterstitialAd();
            },
            onAdShowedFullScreenContent: (ad) {
              // Ad is showing
            },
          );

          print('Interstitial ad loaded successfully');
        },
        onAdFailedToLoad: (error) {
          _isLoading = false;
          _isAdReady = false;
          print('Interstitial ad failed to load: ${error.message}');
          // Retry loading after a delay
          Future.delayed(const Duration(seconds: 5), () {
            loadInterstitialAd();
          });
        },
      ),
    );
  }

  /// Show the interstitial ad if it's ready
  Future<bool> showInterstitialAd() async {
    if (_interstitialAd != null && _isAdReady) {
      _interstitialAd!.show();
      _isAdReady = false;
      return true;
    }
    return false;
  }

  /// Track navigation to widget page and show ad on 5th visit
  Future<void> handleWidgetPageNavigation() async {
    final prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt(_navigationCountKey) ?? 0;
    count++;

    await prefs.setInt(_navigationCountKey, count);

    print('Widget page navigation count: $count');

    // Show ad on 5th navigation
    if (count % 5 == 0) {
      final shown = await showInterstitialAd();
      if (!shown) {
        // If ad is not ready, try to load it for next time
        loadInterstitialAd();
      }
    } else {
      // Preload ad if not already loading or ready
      if (!_isLoading && !_isAdReady) {
        loadInterstitialAd();
      }
    }
  }

  /// Reset navigation count (useful for testing)
  Future<void> resetNavigationCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_navigationCountKey);
  }

  /// Get current navigation count
  Future<int> getNavigationCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_navigationCountKey) ?? 0;
  }

  /// Dispose the interstitial ad
  void dispose() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _isAdReady = false;
    _isLoading = false;
  }
}

/// Singleton instance for easy access
final interstitialAdService = InterstitialAdService();
