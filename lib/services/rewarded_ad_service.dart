import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

/// Service class for managing rewarded ads
/// Follows AdMob policies for rewarded ad implementation
class RewardedAdService {
  static const String _rewardedAdUnitId = 'ca-app-pub-7287011693739626/3720367745';
  
  RewardedAd? _rewardedAd;
  bool _isLoading = false;
  bool _isAdReady = false;
  Function(RewardItem)? _onRewardEarned;
  Function()? _onAdDismissed;
  Function(String)? _onAdFailed;

  // Ad unit ID getter
  static String get rewardedAdUnitId {
    // For testing, you can temporarily replace with test IDs:
    if (kDebugMode) {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/5224354917';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/1712485313';
      }
    }
    return _rewardedAdUnitId;
  }

  /// Load a rewarded ad
  /// Returns true if loading started, false if already loading or ready
  Future<bool> loadRewardedAd({
    Function(RewardItem)? onRewardEarned,
    Function()? onAdDismissed,
    Function(String)? onAdFailed,
  }) async {
    if (_isLoading || _isAdReady) {
      return false;
    }

    _onRewardEarned = onRewardEarned;
    _onAdDismissed = onAdDismissed;
    _onAdFailed = onAdFailed;

    _isLoading = true;

    try {
      await RewardedAd.load(
        adUnitId: rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            _rewardedAd = ad;
            _isAdReady = true;
            _isLoading = false;

            // Set full screen content callback
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                _rewardedAd = null;
                _isAdReady = false;
                _isLoading = false;
                _onAdDismissed?.call();
                // Load a new ad after dismissal
                loadRewardedAd(
                  onRewardEarned: _onRewardEarned,
                  onAdDismissed: _onAdDismissed,
                  onAdFailed: _onAdFailed,
                );
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
                _rewardedAd = null;
                _isAdReady = false;
                _isLoading = false;
                final errorMessage = 'Failed to show rewarded ad: ${error.message}';
                _onAdFailed?.call(errorMessage);
                // Load a new ad after failure
                loadRewardedAd(
                  onRewardEarned: _onRewardEarned,
                  onAdDismissed: _onAdDismissed,
                  onAdFailed: _onAdFailed,
                );
              },
              onAdShowedFullScreenContent: (ad) {
                // Ad is showing
              },
            );

            print('Rewarded ad loaded successfully');
          },
          onAdFailedToLoad: (error) {
            _isLoading = false;
            _isAdReady = false;
            final errorMessage = 'Failed to load rewarded ad: ${error.message}';
            print('Rewarded ad failed to load: $errorMessage');
            _onAdFailed?.call(errorMessage);
          },
        ),
      );
      return true;
    } catch (e) {
      _isLoading = false;
      _isAdReady = false;
      final errorMessage = 'Exception loading rewarded ad: $e';
      print(errorMessage);
      _onAdFailed?.call(errorMessage);
      return false;
    }
  }

  /// Show the rewarded ad if it's ready
  /// Returns true if ad was shown, false otherwise
  Future<bool> showRewardedAd({
    Function(RewardItem)? onRewardEarned,
    Function()? onAdDismissed,
    Function(String)? onAdFailed,
  }) async {
    if (_rewardedAd != null && _isAdReady) {
      // Update callbacks if provided
      if (onRewardEarned != null) _onRewardEarned = onRewardEarned;
      if (onAdDismissed != null) _onAdDismissed = onAdDismissed;
      if (onAdFailed != null) _onAdFailed = onAdFailed;
      
      // Set reward callback before showing
      _rewardedAd!.setImmersiveMode(true);
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          print('User earned reward: ${reward.amount} ${reward.type}');
          _onRewardEarned?.call(reward);
        },
      );
      _isAdReady = false;
      return true;
    }
    return false;
  }

  /// Check if ad is ready to show
  bool get isAdReady => _isAdReady;

  /// Check if ad is currently loading
  bool get isLoading => _isLoading;

  /// Dispose the rewarded ad
  void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
    _isAdReady = false;
    _isLoading = false;
    _onRewardEarned = null;
    _onAdDismissed = null;
    _onAdFailed = null;
  }
}

/// Singleton instance for easy access
final rewardedAdService = RewardedAdService();
