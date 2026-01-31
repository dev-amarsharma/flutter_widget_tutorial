import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'dart:io';

/// Service class for managing banner ads
class BannerAdService {
  static const String _bannerAdUnitId = 'ca-app-pub-7287011693739626/9731422228';
  
  // Ad unit ID getter - returns actual ad unit ID
  // For testing, you can temporarily replace with test IDs:
  // Android: 'ca-app-pub-3940256099942544/6300978111'
  // iOS: 'ca-app-pub-3940256099942544/2934735716'
  static String get bannerAdUnitId {
    // In debug mode, you might want to use test ad unit IDs
    // Uncomment the lines below for testing:
    // if (kDebugMode) {
    //   if (Platform.isAndroid) {
    //     return 'ca-app-pub-3940256099942544/6300978111';
    //   } else if (Platform.isIOS) {
    //     return 'ca-app-pub-3940256099942544/2934735716';
    //   }
    // }
    return _bannerAdUnitId;
  }

  /// Creates a BannerAd with the specified ad unit ID
  static BannerAd createBannerAd({
    required AdSize adSize,
    required void Function(Ad, LoadAdError) onAdFailedToLoad,
    void Function(Ad)? onAdLoaded,
  }) {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          onAdLoaded?.call(ad);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          onAdFailedToLoad(ad, error);
        },
        onAdOpened: (ad) {
          // Ad opened
        },
        onAdClosed: (ad) {
          // Ad closed
        },
      ),
    );
  }

  /// Creates a standard 320x50 adaptive banner ad
  static BannerAd createStandardBanner({
    required void Function(Ad, LoadAdError) onAdFailedToLoad,
    void Function(Ad)? onAdLoaded,
  }) {
    return createBannerAd(
      adSize: AdSize.banner,
      onAdFailedToLoad: onAdFailedToLoad,
      onAdLoaded: onAdLoaded,
    )..load();
  }

  /// Creates an adaptive banner ad that fits the screen width
  static Future<BannerAd> createAdaptiveBanner(
    BuildContext context, {
    required void Function(Ad, LoadAdError) onAdFailedToLoad,
    void Function(Ad)? onAdLoaded,
  }) async {
    final adSize = await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.toInt(),
    );
    
    return createBannerAd(
      adSize: adSize ?? AdSize.banner,
      onAdFailedToLoad: onAdFailedToLoad,
      onAdLoaded: onAdLoaded,
    )..load();
  }
}
