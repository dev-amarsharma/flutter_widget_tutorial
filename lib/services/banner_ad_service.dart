import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import '../config/ad_config.dart';

/// Service class for managing banner ads
class BannerAdService {
  /// Creates a BannerAd with the specified ad unit ID
  static BannerAd createBannerAd({
    required AdSize adSize,
    required void Function(Ad, LoadAdError) onAdFailedToLoad,
    void Function(Ad)? onAdLoaded,
  }) {
    return BannerAd(
      adUnitId: AdConfig.banner,
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
