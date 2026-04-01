# Multi-App Template Guide

This project can now be reused for other topic-based learning apps such as Java, Kotlin, JavaScript, or other programming languages with minimal Dart code changes.

## Reusable structure

For a new app, the main work is:

1. Update [`assets/app_config.json`](/Users/amarsharma/git_personal/FlutterTutorial/assets/app_config.json)
2. Replace or rewrite [`assets/topics_manifest.json`](/Users/amarsharma/git_personal/FlutterTutorial/assets/topics_manifest.json)
3. Add the markdown lessons and quiz JSON files referenced by the manifest
4. Update native publishing identifiers for Android

The code now reads app branding, titles, share text, Play Store link, theme colors, and whether the old Flutter-only fallback catalog should be enabled from `app_config.json`.

## 1. App branding and theme

Edit [`assets/app_config.json`](/Users/amarsharma/git_personal/FlutterTutorial/assets/app_config.json)

Important fields:

- `appName`: visible app name used in sharing copy
- `materialAppTitle`: `MaterialApp` title
- `catalogTitle`: main screen title
- `primaryTopic`: language or subject, for example `Java`, `Kotlin`, `JavaScript`
- `description`: short app description used in sharing text
- `playStoreUrl`: shared store URL
- `features.enableLegacyCatalogFallback`: set this to `false` for non-Flutter apps
- `theme.*`: app colors

Example Java app config:

```json
{
  "appName": "Java Learning Catalog",
  "materialAppTitle": "Java Learning Catalog",
  "catalogTitle": "Java Learning Catalog",
  "primaryTopic": "Java",
  "description": "Learn Java with structured lessons, quizzes, and progress tracking.",
  "playStoreUrl": "https://play.google.com/store/apps/details?id=com.example.java_learning",
  "features": {
    "enableLegacyCatalogFallback": false
  },
  "theme": {
    "primary": "#1565C0",
    "onPrimary": "#FFFFFF",
    "secondary": "#EF6C00",
    "onSecondary": "#FFFFFF",
    "background": "#FFFFFF",
    "onBackground": "#111111",
    "surface": "#CFD8DC",
    "onSurface": "#111111",
    "icon": "#EF6C00",
    "fabBackground": "#EF6C00",
    "fabForeground": "#FFFFFF"
  }
}
```

## 2. Topic catalog

Edit [`assets/topics_manifest.json`](/Users/amarsharma/git_personal/FlutterTutorial/assets/topics_manifest.json)

Define:

- `tracks`
- `topics`
- `lessonAsset`
- `quizAsset`
- `prerequisites`
- `relatedTopicIds`

For a new app, keep `isPublished: true` only for topics whose lesson and quiz files already exist.

## 3. Lesson and quiz files

For every published topic, add:

- `assets/<topic>.md`
- `assets/<topic>_quiz.json`

Quiz JSON format:

```json
[
  {
    "que": "Question text",
    "options": ["A", "B", "C", "D"],
    "ans": "a"
  }
]
```

## 4. Turn off the old Flutter widget fallback

If you are building a Java, Kotlin, JavaScript, or any non-Flutter app:

- Set `features.enableLegacyCatalogFallback` to `false` in `app_config.json`

That prevents the old Flutter widget catalog from being appended behind your new manifest topics.

## 5. Android files you still need to update

These are not driven by app config and must still be changed before publishing a new app.

### Application id

Edit [`android/app/build.gradle.kts`](/Users/amarsharma/git_personal/FlutterTutorial/android/app/build.gradle.kts)

- `applicationId`

### Android label

Edit [`android/app/src/main/AndroidManifest.xml`](/Users/amarsharma/git_personal/FlutterTutorial/android/app/src/main/AndroidManifest.xml)

- `android:label`

### Kotlin package path

Update:

- [`android/app/src/main/kotlin/app/flutter/tutorial/flutter_tutorial/MainActivity.kt`](/Users/amarsharma/git_personal/FlutterTutorial/android/app/src/main/kotlin/app/flutter/tutorial/flutter_tutorial/MainActivity.kt)

and its package directory if the application package changes.

### Firebase and ads

If the new app uses its own app ids:

- update `google-services.json`
- update the AdMob app id in `AndroidManifest.xml`

## 6. Recommended workflow for a new language app

1. Copy this project into a new repo or branch.
2. Update `assets/app_config.json`.
3. Rewrite `assets/topics_manifest.json`.
4. Add lesson markdown and quiz assets.
5. Set legacy fallback to `false`.
6. Audit published topics before build:

```bash
node -e "const fs=require('fs'); const m=JSON.parse(fs.readFileSync('assets/topics_manifest.json','utf8')); for (const t of m.topics.filter(x=>x.isPublished)){ if(!fs.existsSync(t.lessonAsset)||!fs.existsSync(t.quizAsset)) console.log(t.id); }"
```

7. Update Android ids and store metadata.
8. Run:

```bash
flutter clean
flutter pub get
flutter run
```

## What is configurable now

- App title
- Catalog title
- Play Store link in share messages
- Theme colors
- Subject name used in share text
- Whether legacy Flutter fallback content is enabled

## What remains content-specific

- Topic lessons
- Quiz questions
- Track definitions
- Android package id
- App icon, splash, store listing assets
- AdMob and Firebase credentials

## Recommended next step if you plan many apps

If you want to publish many variants from one codebase, the next step should be Android product flavors for:

- package id
- app name
- icons
- Firebase config
- Ad ids

That would reduce manual native edits even further.
