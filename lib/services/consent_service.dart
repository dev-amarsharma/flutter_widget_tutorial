import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Wraps the Google User Messaging Platform (UMP) consent flow.
///
/// AdMob — and every mediated network behind it, including Meta Audience
/// Network — needs a valid consent signal before ads may be requested in
/// regulated regions. Nothing may call `load()` on an ad until
/// [canRequestAds] is true.
class ConsentService {
  /// True once the UMP says ad requests are allowed (consent obtained, or not
  /// required in this region). Ad surfaces listen to this and load when it
  /// flips to true.
  final ValueNotifier<bool> canRequestAds = ValueNotifier(false);

  /// True when the user must be offered a persistent "privacy options" entry
  /// point (GDPR requirement once a consent form was shown).
  final ValueNotifier<bool> privacyOptionsRequired = ValueNotifier(false);

  bool _formFlowRan = false;

  /// Refreshes the cached consent info. Awaits only the (fast) network update,
  /// never the form itself, so app startup is not blocked behind a dialog.
  Future<void> init({List<String> testDeviceIds = const []}) async {
    final params = ConsentRequestParameters(
      consentDebugSettings: kDebugMode && testDeviceIds.isNotEmpty
          ? ConsentDebugSettings(testIdentifiers: testDeviceIds)
          : null,
    );

    final updated = Completer<void>();
    try {
      ConsentInformation.instance.requestConsentInfoUpdate(
        params,
        () {
          if (!updated.isCompleted) updated.complete();
        },
        (error) {
          debugPrint('Consent info update failed: ${error.message}');
          if (!updated.isCompleted) updated.complete();
        },
      );
      // A hung update must not hold the splash screen hostage.
      await updated.future.timeout(const Duration(seconds: 10));
    } catch (e) {
      debugPrint('Consent info update error: $e');
    }

    await refresh();
  }

  /// Re-reads the UMP state into the notifiers.
  Future<void> refresh() async {
    try {
      canRequestAds.value = await ConsentInformation.instance.canRequestAds();
    } catch (e) {
      // Fail open: a UMP plumbing error must not permanently disable ads.
      debugPrint('canRequestAds() failed: $e');
      canRequestAds.value = true;
    }

    try {
      final status = await ConsentInformation.instance
          .getPrivacyOptionsRequirementStatus();
      privacyOptionsRequired.value =
          status == PrivacyOptionsRequirementStatus.required;
    } catch (e) {
      debugPrint('getPrivacyOptionsRequirementStatus() failed: $e');
      privacyOptionsRequired.value = false;
    }
  }

  /// Loads and shows the consent form when the UMP says one is required.
  /// A no-op (returning immediately) when consent is already resolved.
  /// Runs at most once per app session.
  Future<void> showFormIfRequired() async {
    if (_formFlowRan) return;
    _formFlowRan = true;

    final dismissed = Completer<void>();
    try {
      ConsentForm.loadAndShowConsentFormIfRequired((error) {
        if (error != null) {
          debugPrint('Consent form error: ${error.message}');
        }
        if (!dismissed.isCompleted) dismissed.complete();
      });
      await dismissed.future;
    } catch (e) {
      debugPrint('Consent form failed: $e');
    }

    await refresh();
  }

  /// Re-opens the privacy options form from the app's own UI.
  Future<void> showPrivacyOptionsForm() async {
    final dismissed = Completer<void>();
    try {
      ConsentForm.showPrivacyOptionsForm((error) {
        if (error != null) {
          debugPrint('Privacy options form error: ${error.message}');
        }
        if (!dismissed.isCompleted) dismissed.complete();
      });
      await dismissed.future;
    } catch (e) {
      debugPrint('Privacy options form failed: $e');
    }

    await refresh();
  }

  /// Test-only: clears the stored consent so the form shows again.
  Future<void> reset() async {
    await ConsentInformation.instance.reset();
    _formFlowRan = false;
    await refresh();
  }
}

/// Singleton instance used across the app.
final consentService = ConsentService();
