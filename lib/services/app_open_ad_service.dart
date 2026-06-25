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

  bool get _isAdAvailable =>
      _ad != null &&
      _loadTime != null &&
      DateTime.now().difference(_loadTime!) < _adExpiration;

  bool get isShowingAd => _isShowingAd;

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
  }
}

/// Singleton instance used across the app.
final appOpenAdService = AppOpenAdService();
