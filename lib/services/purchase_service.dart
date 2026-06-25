import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String removeAdsProductId = 'remove_ads';
const String _prefsKey = 'ads_removed';

class PurchaseService {
  final ValueNotifier<bool> adsRemoved = ValueNotifier(false);

  StreamSubscription<List<PurchaseDetails>>? _subscription;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    adsRemoved.value = prefs.getBool(_prefsKey) ?? false;

    _subscription = InAppPurchase.instance.purchaseStream.listen(
      _onPurchaseUpdate,
      onDone: _subscription?.cancel,
      onError: (_) {},
    );
  }

  Future<void> _onPurchaseUpdate(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      if (purchase.productID != removeAdsProductId) continue;

      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        await _persist();
        if (purchase.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchase);
        }
      } else if (purchase.status == PurchaseStatus.error) {
        if (purchase.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchase);
        }
      }
    }
  }

  Future<void> _persist() async {
    adsRemoved.value = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, true);
  }

  /// Initiates the one-time "Remove Ads" purchase.
  /// Returns false when IAP is unavailable or the product is not found.
  Future<bool> buyRemoveAds() async {
    if (!await InAppPurchase.instance.isAvailable()) return false;

    final response = await InAppPurchase.instance
        .queryProductDetails({removeAdsProductId});
    if (response.productDetails.isEmpty) return false;

    final param = PurchaseParam(
      productDetails: response.productDetails.first,
    );
    return InAppPurchase.instance.buyNonConsumable(purchaseParam: param);
  }

  Future<void> restorePurchases() async {
    await InAppPurchase.instance.restorePurchases();
  }

  void dispose() {
    _subscription?.cancel();
    adsRemoved.dispose();
  }
}

final purchaseService = PurchaseService();
