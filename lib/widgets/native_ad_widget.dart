import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/consent_service.dart';
import '../services/purchase_service.dart';
import '../config/ad_config.dart';

/// Renders a single native ad using the "listTile" factory registered in
/// NativeAdFactory.kt. Manages its own ad lifecycle (load → display → dispose).
class NativeAdWidget extends StatefulWidget {
  const NativeAdWidget({super.key});

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd? _ad;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    consentService.canRequestAds.addListener(_onConsentChanged);
    purchaseService.adsRemoved.addListener(_onAdsRemovedChanged);
    _maybeLoadAd();
  }

  /// Loads only when the purchase and consent gates both allow it.
  void _maybeLoadAd() {
    if (purchaseService.adsRemoved.value) return;
    if (!consentService.canRequestAds.value) return;
    if (_ad != null) return;
    _loadAd();
  }

  /// The consent form can resolve after this widget was built; load then.
  void _onConsentChanged() {
    if (!mounted) return;
    _maybeLoadAd();
  }

  /// Drops the ad immediately when the user buys "Remove Ads".
  void _onAdsRemovedChanged() {
    if (!purchaseService.adsRemoved.value) return;
    _ad?.dispose();
    _ad = null;
    if (mounted) setState(() => _loaded = false);
  }

  void _loadAd() {
    final ad = NativeAd(
      adUnitId: AdConfig.native,
      factoryId: 'listTile',
      listener: NativeAdListener(
        onAdLoaded: (_) {
          if (!mounted) return;
          setState(() => _loaded = true);
        },
        onAdFailedToLoad: (ad, _) {
          ad.dispose();
          _ad = null;
        },
      ),
      request: const AdRequest(),
    );
    ad.load();
    _ad = ad;
  }

  @override
  void dispose() {
    consentService.canRequestAds.removeListener(_onConsentChanged);
    purchaseService.adsRemoved.removeListener(_onAdsRemovedChanged);
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (purchaseService.adsRemoved.value) return const SizedBox.shrink();
    if (!_loaded || _ad == null) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 220,
          child: AdWidget(ad: _ad!),
        ),
      ),
    );
  }
}
