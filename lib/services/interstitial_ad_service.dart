import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:async';

/// Service class for managing interstitial ads
class InterstitialAdService {
  static const String _interstitialAdUnitId = 'ca-app-pub-7287011693739626/7763734432';
  static const String _navigationCountKey = 'widget_page_navigation_count';
  
  InterstitialAd? _interstitialAd;
  bool _isLoading = false;
  bool _isAdReady = false;
  Completer<void>? _adCompleter;
  Completer<bool>? _loadCompleter;

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
  /// Returns a Future that completes with true if loaded successfully, false otherwise
  Future<bool> loadInterstitialAd() async {
    if (_isAdReady) {
      return true;
    }

    if (_isLoading) {
      return _loadCompleter?.future ?? Future.value(false);
    }

    _isLoading = true;
    _loadCompleter = Completer<bool>();

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
              _adCompleter?.complete();
              _adCompleter = null;
              // Preload next ad
              loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _interstitialAd = null;
              _isAdReady = false;
              _isLoading = false;
              _adCompleter?.complete();
              _adCompleter = null;
              // Preload next ad
              loadInterstitialAd();
            },
            onAdShowedFullScreenContent: (ad) {
              // Ad is showing
            },
          );

          print('Interstitial ad loaded successfully');
          _loadCompleter?.complete(true);
          _loadCompleter = null;
        },
        onAdFailedToLoad: (error) {
          _isLoading = false;
          _isAdReady = false;
          print('Interstitial ad failed to load: ${error.message}');
          _loadCompleter?.complete(false);
          _loadCompleter = null;
          // Retry loading after a delay
          Future.delayed(const Duration(seconds: 10), () {
            loadInterstitialAd();
          });
        },
      ),
    );

    return _loadCompleter?.future ?? Future.value(false);
  }

  /// Show the interstitial ad if it's ready, or load and then show
  /// Returns a Future that completes when the ad is dismissed or failed to show
  Future<bool> showInterstitialAd({bool forceLoad = false}) async {
    if (forceLoad && !_isAdReady) {
      print('Forcing ad load before showing');
      await loadInterstitialAd();
    }

    if (_interstitialAd != null && _isAdReady) {
      _adCompleter = Completer<void>();
      _interstitialAd!.show();
      _isAdReady = false;
      await _adCompleter!.future;
      return true;
    }
    
    print('No interstitial ad ready to show');
    return false;
  }

  /// Check if an ad is ready
  bool get isAdReady => _isAdReady;

  /// Check if currently loading
  bool get isLoading => _isLoading;

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
