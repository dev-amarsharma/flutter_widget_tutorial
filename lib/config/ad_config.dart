import 'dart:io';
import 'package:flutter/foundation.dart';

/// Central registry for all AdMob ad unit IDs.
/// In debug mode, Google's official test IDs are returned automatically.
class AdConfig {
  AdConfig._();

  // ── Production IDs ───────────────────────────────────────────────────────
  // NOTE: The AdMob app ID (ca-app-pub-7287011693739626~8120775629) is declared
  // natively in AndroidManifest.xml (com.google.android.gms.ads.APPLICATION_ID),
  // not here. This class only holds ad *unit* IDs.
  static const String _bannerProd = 'ca-app-pub-7287011693739626/5033449413';
  static const String _interstitialProd = 'ca-app-pub-7287011693739626/5357611990';
  static const String _appOpenProd = 'ca-app-pub-7287011693739626/7276207012';
  static const String _rewardedProd = 'ca-app-pub-7287011693739626/3720367745';
  static const String _nativeProd = 'ca-app-pub-7287011693739626/4722104945';

  // ── Public getters (test IDs in debug, production IDs in release) ────────
  static String get banner {
    if (kDebugMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
    }
    return _bannerProd;
  }

  static String get interstitial {
    if (kDebugMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910';
    }
    return _interstitialProd;
  }

  static String get rewarded {
    if (kDebugMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/5224354917'
          : 'ca-app-pub-3940256099942544/1712485313';
    }
    return _rewardedProd;
  }

  static String get appOpen {
    if (kDebugMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/9257395921'
          : 'ca-app-pub-3940256099942544/5665264844';
    }
    return _appOpenProd;
  }

  static String get native {
    if (kDebugMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/2247696110'
          : 'ca-app-pub-3940256099942544/3986624511';
    }
    return _nativeProd;
  }
}
