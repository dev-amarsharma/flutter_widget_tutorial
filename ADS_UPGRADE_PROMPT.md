# Ads & Monetization Upgrade — Reproduction Prompt

This document is a **reusable prompt**. Hand it to an AI coding agent (or a developer)
to reproduce, on any branch of this Flutter app, the complete ads/monetization
implementation from the `project_ad_upgrade` branch.

> **Goal:** Integrate a full AdMob ad stack (banner, interstitial, rewarded, app‑open,
> native) with Meta (Facebook) Audience Network mediation, a one‑time "Remove Ads"
> in‑app purchase, and the supporting UX (expandable FAB, portrait lock, app sharing,
> "More apps"). Do **not** delete existing app content; only add/modify what's listed.

---

## 0. Ground rules

- Preserve all existing screens, assets, and content. This is additive.
- Use Google's official **test ad unit IDs in debug** and real IDs in release
  (handled centrally by `AdConfig`).
- Every ad surface must respect the "Remove Ads" purchase.
- Verify after each section: imports resolve, no circular imports, balanced braces.

---

## 1. Dependencies (`pubspec.yaml`)

Add/ensure these under `dependencies:` (versions used by `project_ad_upgrade`):

```yaml
google_mobile_ads: ^9.0.0      # AdMob: banner, interstitial, rewarded, app-open, native
in_app_purchase: ^3.2.0        # "Remove Ads" one-time purchase
url_launcher: ^6.3.0           # "More apps" external link
share_plus: ^13.1.0            # App sharing  (>= the version your Flutter supports)
shared_preferences: ^2.1.0     # Persist the ads-removed flag
connectivity_plus: ^7.1.1
```

Run `flutter pub get` afterward.

---

## 2. Central ad-unit registry — `lib/config/ad_config.dart`

A single class that returns **test IDs in `kDebugMode`** and production IDs otherwise.
Expose static getters: `banner`, `interstitial`, `rewarded`, `appOpen`, `native`.

- Keep production unit IDs in `private static const` fields.
- The AdMob **app ID** itself does NOT live here — it goes in `AndroidManifest.xml`.
- Replace the production unit IDs with the target app's real IDs.

## 3. Ad services — `lib/services/`

Create one singleton service per format. Each is exposed as a bottom-of-file
`final xxxAdService = XxxAdService();`.

| File | Responsibility | Remove-Ads guard |
|------|----------------|------------------|
| `banner_ad_service.dart` | Factory for `BannerAd` (standard + adaptive) using `AdConfig.banner` | (gated in the widget) |
| `interstitial_ad_service.dart` | Load/show interstitial; `showInterstitialAd({forceLoad})`; `handleWidgetPageNavigation()` shows on every 5th nav | `showInterstitialAd` returns early if `adsRemoved` |
| `rewarded_ad_service.dart` | Load/show rewarded; reward callback | **Exempt** (opt-in "watch for reward") |
| `app_open_ad_service.dart` | Cold-start / resume app-open ad; 4‑hour expiry + auto-reload | `loadAd` & `showAdIfAvailable` guard |
| `consent_service.dart` | Google UMP wrapper; `canRequestAds` / `privacyOptionsRequired` `ValueNotifier<bool>`; `init()`, `refresh()`, `showFormIfRequired()`, `showPrivacyOptionsForm()` | — (gates every ad load) |
| `purchase_service.dart` | `in_app_purchase` wrapper; `adsRemoved` `ValueNotifier<bool>`; `buyRemoveAds()`, `restorePurchases()`; persists to `SharedPreferences` (`remove_ads` product, `ads_removed` key) | — (source of truth) |

Key contracts:
- `purchaseService.adsRemoved` is a `ValueNotifier<bool>` every ad surface listens to / checks.
- `consentService.canRequestAds` is a `ValueNotifier<bool>` every ad **load** checks before
  requesting; banner/native widgets also listen so they load when consent resolves late.

## 4. Ad widgets — `lib/widgets/`

- `banner_ad_widget.dart` — `BannerAdWidget`: loads a banner, but
  - skips loading when `adsRemoved` is already true,
  - renders `SizedBox.shrink()` when removed or on load error,
  - listens to `adsRemoved` and disposes the banner immediately on purchase,
  - disposes/reloads across `paused`/`resumed` lifecycle.
- `native_ad_widget.dart` — `NativeAdWidget`: loads a native ad via `factoryId: 'listTile'`,
  skips load + renders nothing when `adsRemoved`.

---

## 5. Android native setup

### 5.1 `android/app/src/main/kotlin/.../MainActivity.kt`
Register the native ad factory in `configureFlutterEngine` and unregister in
`cleanUpFlutterEngine`, using factory id **`"listTile"`** and a `NativeAdFactory(applicationContext)`.

### 5.2 `android/app/src/main/kotlin/.../NativeAdFactory.kt`
Implement `io.flutter.plugins.googlemobileads.NativeAdFactory`, inflate
`R.layout.native_ad`, bind headline / body / cta / icon / stars / advertiser / media,
call `setNativeAd(nativeAd)`.

### 5.3 `android/app/src/main/res/layout/native_ad.xml`
A `NativeAdView` layout with the views referenced above (an "Ad" badge, icon+headline
row, body, rating bar, `MediaView`, CTA button).

### 5.4 `android/app/src/main/AndroidManifest.xml`
Inside `<application>`:
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-XXXXXXXXXXXX~YYYYYYYYYY"/>   <!-- AdMob APP ID for THIS app -->
<meta-data
    android:name="com.facebook.sdk.ApplicationId"
    android:value="@string/facebook_app_id"/>             <!-- Meta AN mediation -->
```
Inside (or add) `<queries>`:
```xml
<package android:name="com.facebook.katana" />
<package android:name="com.facebook.lite" />
<!-- plus an https VIEW intent if using url_launcher for "More apps" -->
<intent>
    <action android:name="android.intent.action.VIEW"/>
    <data android:scheme="https"/>
</intent>
```
Also lock the launch activity to portrait: `android:screenOrientation="portrait"` on `MainActivity`.

### 5.5 `android/app/src/main/res/values/strings.xml`
```xml
<resources>
    <string name="facebook_app_id">REPLACE_WITH_THIS_APPS_META_APP_ID</string>
</resources>
```

### 5.6 `android/app/build.gradle.kts`
```kotlin
android {
    compileSdk = 36           // REQUIRED: google_mobile_ads / in_app_purchase / webview need API 36
    compileOptions { isCoreLibraryDesugaringEnabled = true }   // + Java 17 source/target
    buildTypes {
        getByName("release") {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("com.google.ads.mediation:facebook:6.21.0.3")        // Meta AN adapter
    implementation("com.google.android.gms:play-services-ads-identifier:18.2.0")
}
```

### 5.7 `android/app/proguard-rules.pro`
Required because release minification is enabled. Keep: `com.facebook.**`,
`com.google.android.gms.ads.**`, `com.google.ads.**`, `io.flutter.**`; add
`-dontwarn` for optional Facebook annotations and Play Core split-install classes;
keep Room/WorkManager classes. (Use the `project_ad_upgrade` file verbatim.)

---

## 5A. Meta (Facebook) Audience Network mediation with AdMob — end-to-end setup

Audience Network does not serve ads on its own here; it is **mediated through AdMob**.
AdMob remains the primary SDK (`google_mobile_ads`), and the Meta adapter lets AdMob
request demand from Audience Network. Setup has a **dashboard** half and an **app** half.

### 5A.1 Meta / Audience Network dashboard
1. Create a Meta app at <https://developers.facebook.com> and add the **Audience Network** product.
2. In **Monetization Manager** (<https://business.facebook.com/monetization>), add (or select)
   the **Property** (your app) and accept the AN terms / set up payouts.
3. Create one **Placement** per ad format you mediate (Banner, Interstitial, Rewarded,
   Native, App Open). Each placement gets a **Placement ID** of the form `APPID_PLACEMENTID`.
4. Note your **Meta App ID** (numeric) — this goes in `strings.xml` (`facebook_app_id`).

### 5A.2 AdMob console — link Audience Network as a mediation source
1. In AdMob, go to **Mediation → Create Mediation Group**, choose the **format** and platform
   (Android), and attach it to your existing AdMob **ad unit(s)**.
2. Add an ad source: **Meta Audience Network** → enable **"Optimize"** (bidding) or set a
   manual eCPM waterfall.
3. When prompted, enter the **Placement ID** from step 5A.1 for that format and your
   Meta App ID. AdMob may ask you to **link your Meta account** so it can read eCPM /
   manage the bidding partnership — approve the partnership in Monetization Manager.
4. Map each AdMob ad unit (the IDs in `lib/config/ad_config.dart`) to the matching
   mediation group. Repeat per format.

### 5A.3 App side — adapter, manifest, proguard (already covered above, summarized)
- **Adapter dependency** in `android/app/build.gradle.kts`:
  ```kotlin
  implementation("com.google.ads.mediation:facebook:6.21.0.3")   // Meta AN adapter for AdMob
  implementation("com.google.android.gms:play-services-ads-identifier:18.2.0")
  ```
  (Keep the adapter version compatible with `google_mobile_ads ^9.0.0`; check the
  [adapter changelog](https://developers.google.com/admob/android/mediation/meta) and bump if needed.)
- **`strings.xml`** — `facebook_app_id` = your numeric Meta App ID.
- **`AndroidManifest.xml`** — inside `<application>`:
  ```xml
  <meta-data android:name="com.facebook.sdk.ApplicationId"
             android:value="@string/facebook_app_id"/>
  ```
  and inside `<queries>`:
  ```xml
  <package android:name="com.facebook.katana" />
  <package android:name="com.facebook.lite" />
  ```
- **`proguard-rules.pro`** — keep `com.facebook.**` (+ `-dontwarn` the optional
  `com.facebook.infer.annotation.*` classes). Already in the supplied proguard file.
- **No Dart changes** — the app keeps calling `google_mobile_ads` as normal
  (`AdConfig.banner`, `AdConfig.interstitial`, …). AdMob picks Meta demand automatically
  when its eCPM wins.

### 5A.4 Consent / privacy (required for serving Meta ads)
- Audience Network requires a valid consent signal (GDPR/CCPA). Use the **Google UMP /
  AdMob consent** flow (`ConsentInformation`/`ConsentForm`) or a CMP; AdMob forwards the
  consent string to the Meta adapter.
- Implemented by `lib/services/consent_service.dart`:
  - `main()` calls `consentService.refresh()` (a local, cached read — startup is never
    blocked on the network) and preloads ads only when `canRequestAds` is true.
  - The home screen's first frame calls `consentService.init()` (network update, 10 s
    timeout) then `showFormIfRequired()`; ad surfaces load as soon as consent resolves.
  - A **Privacy options** FAB action appears whenever
    `PrivacyOptionsRequirementStatus.required`, calling `ConsentForm.showPrivacyOptionsForm`.
  - Every `loadAd` (banner, native, interstitial, rewarded, app-open) returns early while
    `canRequestAds` is false, so no request precedes consent. UMP plumbing errors fail
    open so a transient glitch cannot permanently disable ads.
- For test devices, you can call AN test mode via the adapter, or use AdMob's
  `RequestConfiguration(testDeviceIds: [...])` (already set in `main()`), which makes
  mediated networks serve test ads on those devices.

### 5A.5 Verify the mediation
1. Build a release (or test-device) build and open a screen with each ad format.
2. In AdMob → **Mediation → (group) → Ad source report**, confirm Meta requests/impressions
   appear after traffic flows (can take a few hours).
3. Use the Google Mobile Ads **Ad Inspector** (`MobileAds.instance.openAdInspector(...)`)
   on a device to see, per ad unit, whether the Meta adapter initialized and is filling.
   A debug-only "Ad inspector" FAB action opens it (`kDebugMode`-gated in `main.dart`).
4. Common pitfalls: wrong Placement ID, account not linked / partnership not approved,
   missing `facebook_app_id`, adapter version mismatch with `google_mobile_ads`, or
   consent not collected (AN won't fill without it in regulated regions).

---

## 6. App wiring & ad placement — `lib/main.dart`

In `main()` (before `runApp`):
1. `WidgetsFlutterBinding.ensureInitialized();`
2. `SystemChrome.setPreferredOrientations([portraitUp, portraitDown]);` (portrait lock)
3. `await purchaseService.init();`
4. `await MobileAds.instance.initialize();` + test-device `RequestConfiguration`
5. `await consentService.refresh();` (cached UMP state — no network wait)
6. **Only if `!purchaseService.adsRemoved.value && consentService.canRequestAds.value`:**
   preload interstitial + `appOpenAdService.loadAd()`

In the home screen state (`with WidgetsBindingObserver`):
- Show the app-open ad on first frame (`addPostFrameCallback`) and on
  `didChangeAppLifecycleState(resumed)`.
- On that same first frame, run `consentService.init()` → `showFormIfRequired()` and
  restart the ad preloads if consent has only just been granted.
- Bottom `BannerAdWidget` in `bottomNavigationBar`.
- Replace the plain FAB with an **`ExpandableFab`** (see §7) whose actions are:
  My Performance, **Remove Ads** (hidden when `adsRemoved`), Share app, Clear history, More apps,
  **Privacy options** (only when the UMP requires it), Ad inspector (debug builds only).
- A "Remove Ads" bottom sheet calling `purchaseService.buyRemoveAds()` / `restorePurchases()`.

Place ads elsewhere:
- Quiz screen: interstitial before result/lives-lost dialog; rewarded for extra life; bottom banner.
- Widget preview: interstitial on open (`forceLoad`), bottom banner.
- Catalog list: inject a `NativeAdWidget` every N items (remap list indices accordingly).
- Performance screen: bottom banner.

---

## 7. Supporting UX

- `lib/widgets/expandable_fab.dart` — animated speed-dial FAB
  (`ExpandableFab` + `ExpandableFabAction`); open/close with `AnimatedIcon`.
- `lib/services/app_share_service.dart` — `shareApp(context, {extraText})` via `share_plus`.
- **More apps** — `launchUrl(Uri.parse('https://<your-apps-page>/'), mode: externalApplication)`.

---

## 8. Enhancements applied during integration (recommended)

These were added on top of the raw `project_ad_upgrade` code to fix real-world issues —
include them:

1. **App-open ad must only show on a genuine return to the app.** Interstitial/rewarded
   ads, the share sheet, external links, and the billing dialog all background the app
   and fire `resumed`, wrongly triggering app-open. Add to `app_open_ad_service.dart`:
   - `setFullScreenAdShowing(bool)` — interstitial & rewarded set it `true` on show and
     `false` ~1s after dismiss (the tail covers the resume race).
   - `suppressNextResume()` — one-shot (auto-clears after 60s); call it before share,
     `launchUrl`, and buy/restore.
   - `showAdIfAvailable()` returns early if either guard is active.
2. **Remove-Ads purchase coverage** — confirm banner, native, interstitial, app-open all
   check `adsRemoved`; rewarded stays exempt (opt-in). Skip ad preloads at startup for
   paid users.
3. **Consent before requests** — the UMP gate lives in the ad *services*, not the screens,
   so no call site can accidentally request an ad before consent; widgets listen to
   `canRequestAds` so a late consent grant still fills the surface that was skipped.
4. **Build config** — pin `compileSdk = 36` (don't rely on `flutter.compileSdkVersion`);
   create `proguard-rules.pro` (R8 fails without it when minify is on); add `strings.xml`
   if missing (the `@string/facebook_app_id` reference won't compile otherwise).

---

## 9. Replace-before-release checklist

- [x] Real AdMob **app ID** in `AndroidManifest.xml`.
- [x] Real ad **unit IDs** in `lib/config/ad_config.dart`.
- [x] Real **Meta App ID** in `strings.xml` (`facebook_app_id`) — set; re-verify it is this
      app's own Meta App ID before shipping.
- [ ] `remove_ads` product configured in Google Play Console. *(Play Console — external)*
- [ ] Meta Audience Network placement configured & mediation group set in AdMob.
      *(AdMob / Monetization Manager — external)*
- [x] Build artifacts (`**/build/`) are git-ignored, not committed.
- [x] `flutter build appbundle --release` passes (install Android SDK Platform 36 if prompted).

---

## 10. File manifest (what to create/modify)

```
pubspec.yaml                                   (deps)
lib/config/ad_config.dart                      (new)
lib/services/banner_ad_service.dart            (new)
lib/services/interstitial_ad_service.dart      (new)
lib/services/rewarded_ad_service.dart          (new)
lib/services/app_open_ad_service.dart          (new)
lib/services/purchase_service.dart             (new)
lib/services/consent_service.dart              (new — Google UMP consent gate)
lib/services/app_share_service.dart            (new/verify)
lib/widgets/banner_ad_widget.dart              (new)
lib/widgets/native_ad_widget.dart              (new)
lib/widgets/expandable_fab.dart                (new)
lib/main.dart                                  (init, placement, FAB, orientation, IAP sheet)
lib/screens/quiz_screen.dart                   (interstitial + rewarded + banner)
lib/widget_preview_page.dart                   (interstitial + banner)
lib/widget_catalog_page.dart                   (native ad injection + interstitial nav)
lib/screens/performance_screen.dart            (banner)
android/app/build.gradle.kts                   (compileSdk 36, minify, FB mediation deps)
android/app/proguard-rules.pro                 (new)
android/app/src/main/AndroidManifest.xml       (AdMob id, FB id, queries, portrait)
android/app/src/main/res/values/strings.xml    (facebook_app_id)
android/app/src/main/res/layout/native_ad.xml  (new)
android/app/src/main/kotlin/.../MainActivity.kt    (register native factory)
android/app/src/main/kotlin/.../NativeAdFactory.kt (new)
```
