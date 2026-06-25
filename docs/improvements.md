# HTML JS Learning Hub — Improvement Roadmap

This document lists concrete improvements that can be made to the app,
grouped by theme. Each item includes a priority rating (High / Medium / Low),
an effort estimate (S = days, M = 1-2 weeks, L = 3+ weeks), and the key
files that would need to change.

---

## 1. Monetisation (Ad Layer)

| # | Improvement | Priority | Effort | Key files |
|---|-------------|----------|--------|-----------|
| M1 | **App Open Ads** ✅ _Implemented_ | High | S | `lib/services/app_open_ad_service.dart`, `lib/main.dart` |
| M2 | **Native ads in lesson list** ✅ _Implemented_ — `NativeAdFactory.kt` + `native_ad.xml` layout; `NativeAdWidget` Flutter widget; injected every 3 sections in catalog list | High | S | `lib/widget_catalog_page.dart`, `android/app/src/main/kotlin/.../NativeAdFactory.kt` |
| M3 | **Remove-ads IAP** ✅ _Implemented_ — `PurchaseService` + `in_app_purchase ^3.2.0`; product ID `remove_ads`; guards on all ad services; "Remove Ads" bottom sheet in catalog app bar. ⚠️ Create `remove_ads` product in Play Console (see `docs/play_console_remove_ads_iap.md`) | Medium | M | `lib/services/purchase_service.dart`, `pubspec.yaml`, all ad services |
| M4 | **Premium subscription** — monthly/annual plan unlocking all topics, offline downloads, and no ads | Low | L | New `lib/services/subscription_service.dart`, `lib/screens/premium_screen.dart` |

**M1 — App Open Ad setup checklist (action required):**

1. In AdMob console → your app → Ad units → Add ad unit → **App open**.
2. Copy the generated unit ID.
3. Replace the placeholder in `lib/services/app_open_ad_service.dart`:
   ```dart
   static const String _productionAdUnitId =
       'ca-app-pub-7287011693739626/REPLACE_WITH_APP_OPEN_UNIT_ID';
   ```
4. Also add the Meta mediation adapter in `android/app/build.gradle.kts`
   (already done — see `docs/handsoff_for_flutter`).

---

## 2. User Experience & Design

| # | Improvement | Priority | Effort | Key files |
|---|-------------|----------|--------|-----------|
| U1 | **Dark mode** ✅ _Implemented_ — `ThemeService` + `ValueNotifier<ThemeMode>`; `darkTheme` in `app_config.json`; sun/moon toggle in catalog app bar | High | S | `lib/main.dart`, `assets/app_config.json`, `lib/models/app_config.dart`, `lib/services/theme_service.dart` |
| U2 | **Onboarding flow** ✅ _Implemented_ — 3-page PageView (Browse Lessons / Test Your Skills / Track Progress); Skip + Next/Get Started buttons; gated by `seen_onboarding` SharedPreferences key; App Open ad deferred until after onboarding | High | S | `lib/screens/onboarding_screen.dart`, `lib/main.dart` |
| U3 | **Bookmarks / Favourites** ✅ _Implemented_ — heart icon on each lesson card; `isBookmarked`/`toggleBookmark` in `PerformanceService` persisted to SharedPreferences; "Bookmarks (N)" animated filter chip filters catalog to bookmarked items | Medium | S | `lib/services/performance_service.dart`, `lib/widget_catalog_page.dart` |
| U4 | **Improved lesson typography** ✅ _Implemented_ — `flutter_highlight ^0.7.0` + `markdown ^7.3.0`; `_CodeBlockBuilder` replaces code blocks with `HighlightView` (github/atom-one-dark themes); copy-to-clipboard button on each block; inline code warm-orange tint | Medium | S | `lib/widget_preview_page.dart`, `pubspec.yaml` |
| U5 | **Lesson search within content** — `Ctrl+F`-style in-page search that highlights matching text in the markdown viewer | Low | M | `lib/widget_preview_page.dart` |
| U6 | **Accessibility** — semantic labels on all icon buttons, minimum 44×44 tap targets, respects `MediaQuery.textScaleFactor` | Medium | M | All screen/widget files |

---

## 3. Engagement & Retention

| # | Improvement | Priority | Effort | Key files |
|---|-------------|----------|--------|-----------|
| E1 | **Daily learning streak** ✅ _Implemented_ — streak persisted in SharedPreferences; flame chip in catalog search area; streak stat in performance screen | High | S | `lib/services/performance_service.dart`, `lib/widget_catalog_page.dart`, `lib/screens/performance_screen.dart` |
| E2 | **Push notifications** ✅ _Implemented_ — daily reminder via `firebase_messaging` + `flutter_local_notifications`; configurable time via bell icon → time picker sheet; `POST_NOTIFICATIONS` permission in manifest | High | M | `lib/services/notification_service.dart`, `android/app/src/main/AndroidManifest.xml`, `pubspec.yaml` |
| E3 | **"Lesson of the Day"** ✅ _Implemented_ — surfaces one unread lesson per day (day-of-year seed, persisted in SharedPreferences); gradient card pinned above catalog list | Medium | S | `lib/widget_catalog_page.dart`, `lib/services/lesson_of_day_service.dart` |
| E4 | **Share progress** ✅ _Implemented_ — share button in performance screen app bar; message includes read %, avg quiz score, streak, and level; delegates to `AppShareService` via `share_plus` | Low | S | `lib/screens/performance_screen.dart`, `lib/services/app_share_service.dart` |

---

## 4. Gamification

| # | Improvement | Priority | Effort | Key files |
|---|-------------|----------|--------|-----------|
| G1 | **XP & level system** ✅ _Implemented_ — 10 XP/lesson, score-delta XP/quiz; 6 levels (Beginner→Master); XP card with level progress bar on performance screen | High | S | `lib/services/performance_service.dart`, `lib/screens/performance_screen.dart` |
| G2 | **Achievements / Badges** ✅ _Implemented_ — 9 badges (First Step, Bookworm, Scholar, Quiz Debut, Quiz Ace, On a Roll, Dedicated, XP Hunter, Daily Challenger); badge gallery on performance screen (unlocked=coloured, locked=grey); unlock snackbars after lesson read and quiz save | Medium | M | `lib/services/achievement_service.dart`, `lib/screens/performance_screen.dart`, `lib/widget_preview_page.dart` |
| G3 | **Leaderboard** — weekly high-score board via Firebase Firestore; anonymous by default, optional display name | Low | L | New `lib/services/leaderboard_service.dart`, new `lib/screens/leaderboard_screen.dart` |
| G4 | **Daily Challenge** ✅ _Implemented_ — 5 questions/day seeded by date; 20 s timer; +50 XP bonus; challenge card in catalog (between Lesson of Day and Continue Learning); resets at midnight; triggers achievement + XP checks | Medium | M | `lib/services/daily_challenge_service.dart`, `lib/widget_catalog_page.dart` |

---

## 5. Content Expansion

| # | Improvement | Priority | Effort | Key files |
|---|-------------|----------|--------|-----------|
| C1 | **CSS track** ✅ _Implemented_ — 14 lessons + 14 quizzes (`assets/css_*.md` + `assets/css_*_quiz.json`); two new tracks in `topics_manifest.json`: `css_foundations` (10 beginner topics) and `css_advanced` (4 intermediate topics) | High | M | `assets/css_*.md`, `assets/css_*_quiz.json`, `assets/topics_manifest.json` |
| C2 | **React / Vue basics track** — introductory modules on the most popular JS frameworks | Medium | L | `assets/`, `assets/topics_manifest.json` |
| C3 | **Interactive code playground** ✅ _Implemented_ — tabbed HTML/CSS/JS editor + WebView live preview + Run button; integrated via code icon in lesson app bar; "Try it!" button on code blocks pre-populates playground; `webview_flutter ^4.0.0` | High | L | `lib/screens/code_playground_screen.dart`, `pubspec.yaml` |
| C4 | **Video lessons** — short explainer videos (YouTube embeds) attached to complex topics | Low | M | `lib/widget_preview_page.dart`, `lib/models/topic_manifest.dart` |

---

## 6. Technical Quality

| # | Improvement | Priority | Effort | Key files |
|---|-------------|----------|--------|-----------|
| T1 | **State management migration** — replace ad-hoc singletons with `Riverpod` providers for reactivity and testability | Medium | L | All `lib/services/`, all screen files |
| T2 | **Firebase Analytics** ✅ _Implemented_ — `firebase_core ^3.3.0` + `firebase_analytics ^11.2.0` added; `AnalyticsService` logs lesson_opened, quiz_completed, level_up, screen_view, ad_shown. ⚠️ Replace `android/app/google-services.json` with config for app ID `digimonk.app.htmljs` | High | S | `lib/main.dart`, `lib/services/analytics_service.dart`, `pubspec.yaml` |
| T3 | **Firebase Crashlytics** ✅ _Implemented_ — `firebase_crashlytics ^4.1.0` added; `FlutterError.onError` + `PlatformDispatcher.instance.onError` wired up; Crashlytics Gradle plugin `3.0.3` applied in `settings.gradle.kts` + `app/build.gradle.kts` | High | S | `lib/main.dart`, `pubspec.yaml`, `android/settings.gradle.kts`, `android/app/build.gradle.kts` |
| T4 | **Cloud progress sync** — back up read lessons and quiz scores to Firestore so users keep progress across devices/reinstalls | Medium | M | `lib/services/performance_service.dart`, new Firestore integration |
| T5 | **Unit & widget tests** — test ad services, quiz scoring logic, and catalog filtering; target 60 %+ coverage | Medium | M | `test/` directory |
| T6 | **Kotlin version upgrade** ✅ _Implemented_ — bumped Kotlin 1.8.22 → 2.1.0 in `android/settings.gradle.kts` | High | S | `android/settings.gradle.kts` |

---

## Quick-win shortlist (can ship in < 1 day each)

1. **T6** ✅ — Kotlin version bump (one-line change, removes build warning)
2. **U1** ✅ — Dark mode toggle (add dark theme JSON + Flutter `ThemeMode` switch)
3. **E1** ✅ — Daily streak counter (small addition to `PerformanceService`)
4. **G1** ✅ — XP system (extend `PerformanceService`, update performance screen)
5. **T2** ✅ — Firebase Analytics (add package, log 3-4 key events)
6. **E3** ✅ — Lesson of the Day card (day-of-year seed, SharedPreferences persistence)
7. **E4** ✅ — Share progress (share button on performance screen, progress stats in message)

## Current status (2026-05-31)

Phases 1–5 and most of Phase 6 are complete. Remaining open items:

| # | Item | Priority | Effort |
|---|------|----------|--------|
| U5 | Lesson search within content | Low | M |
| U6 | Accessibility | Medium | M |
| G3 | Leaderboard (Firestore) | Low | L |
| C2 | React / Vue basics track | Medium | L |
| C4 | Video lessons | Low | M |
| T1 | State management → Riverpod | Medium | L |
| T4 | Cloud progress sync (Firestore) | Medium | M |
| T5 | Unit & widget tests (60 %+ coverage) | Medium | M |
| M4 | Premium subscription | Low | L |
