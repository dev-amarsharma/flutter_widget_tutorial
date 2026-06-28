import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'purchase_service.dart';
import '../config/ad_config.dart';

/// Manages App Open ads shown on cold start and foreground resume.
///
/// App Open ads expire after 4 hours, so the service tracks load time
/// and reloads automatically when the cached ad becomes stale.
class AppOpenAdService {
  static const Duration _adExpiration = Duration(hours: 4);

  AppOpenAd? _ad;
  bool _isLoading = false;
  bool _isShowingAd = false;
  DateTime? _loadTime;

  /// True while another full-screen ad (interstitial / rewarded) is visible.
  /// The App Open ad must NOT show when the app resumes from one of those.
  bool _fullScreenAdShowing = false;

  /// One-shot guard: when the app intentionally sends the user out (share
  /// sheet, external link, purchase flow), the next resume is ignored.
  bool _suppressNextResume = false;
  Timer? _suppressTimer;

  bool get _isAdAvailable =>
      _ad != null &&
      _loadTime != null &&
      DateTime.now().difference(_loadTime!) < _adExpiration;

  bool get isShowingAd => _isShowingAd;

  /// Marks whether an interstitial or rewarded ad is currently on screen.
  /// A short tail keeps the guard up so the resume event that fires when the
  /// ad closes does not also trigger an App Open ad.
  void setFullScreenAdShowing(bool showing) {
    if (showing) {
      _fullScreenAdShowing = true;
    } else {
      Future.delayed(const Duration(milliseconds: 1000), () {
        _fullScreenAdShowing = false;
      });
    }
  }

  /// Ignore the very next foreground resume (e.g. returning from the share
  /// sheet, an external link, or the purchase dialog). Auto-clears after a
  /// minute so a stale flag never blocks a genuine background return.
  void suppressNextResume() {
    _suppressNextResume = true;
    _suppressTimer?.cancel();
    _suppressTimer = Timer(const Duration(seconds: 60), () {
      _suppressNextResume = false;
    });
  }

  /// Load an App Open ad. No-op if one is already cached or loading.
  Future<void> loadAd() async {
    if (purchaseService.adsRemoved.value) return;
    if (_isLoading || _isAdAvailable) return;
    _isLoading = true;

    await AppOpenAd.load(
      adUnitId: AdConfig.appOpen,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
          _loadTime = DateTime.now();
          _isLoading = false;
        },
        onAdFailedToLoad: (error) {
          _isLoading = false;
          // Retry after 30 s to avoid hammering the network on failure.
          Future.delayed(const Duration(seconds: 30), loadAd);
        },
      ),
    );
  }

  /// Show the cached ad if available, then pre-load the next one.
  /// Does nothing when another full-screen ad is already visible.
  Future<void> showAdIfAvailable() async {
    if (purchaseService.adsRemoved.value) return;
    if (_isShowingAd) return;

    // Don't show when resuming from one of our own full-screen ads...
    if (_fullScreenAdShowing) return;

    // ...or when returning from a share sheet / external link / purchase flow.
    if (_suppressNextResume) {
      _suppressNextResume = false;
      _suppressTimer?.cancel();
      return;
    }

    if (!_isAdAvailable) {
      loadAd();
      return;
    }

    _ad!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) {
        _isShowingAd = true;
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _ad = null;
        _loadTime = null;
        loadAd();
      },
      onAdFailedToShowFullScreenContent: (ad, _) {
        _isShowingAd = false;
        ad.dispose();
        _ad = null;
        _loadTime = null;
        loadAd();
      },
    );

    _isShowingAd = true;
    await _ad!.show();
  }

  void dispose() {
    _ad?.dispose();
    _ad = null;
    _isLoading = false;
    _isShowingAd = false;
    _suppressTimer?.cancel();
  }
}

/// Singleton instance used across the app.
final appOpenAdService = AppOpenAdService();
