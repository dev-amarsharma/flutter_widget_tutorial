import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/banner_ad_service.dart';

/// Reusable widget that displays a banner ad at the bottom of the screen
class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget>
    with WidgetsBindingObserver {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  bool _isAdError = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadBannerAd();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _bannerAd?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (!_isAdLoaded && !_isAdError) {
        _loadBannerAd();
      }
    }
  }

  void _loadBannerAd() {
    _bannerAd = BannerAdService.createStandardBanner(
      onAdLoaded: (ad) {
        setState(() {
          _isAdLoaded = true;
          _isAdError = false;
        });
      },
      onAdFailedToLoad: (ad, error) {
        ad.dispose();
        setState(() {
          _isAdLoaded = false;
          _isAdError = true;
        });
        print('Banner ad failed to load: ${error.message}');
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAdError) {
      // Don't show anything if ad failed to load
      return const SizedBox.shrink();
    }

    if (!_isAdLoaded) {
      // Show loading placeholder or nothing
      return const SizedBox(
        height: 50,
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (_bannerAd == null) {
      return const SizedBox.shrink();
    }

    return Container(
      alignment: Alignment.center,
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
