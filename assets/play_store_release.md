# Play Store Release

## Overview
A Play Store release is the process of preparing, signing, testing, and publishing an Android app build through Google Play. It includes technical readiness, store listing quality, and rollout strategy.

## Release preparation
- Ensure the app is stable and tested on target devices.
- Update version code and version name appropriately.
- Prepare release notes, screenshots, icons, and store listing content.

## Build and signing
- Generate a release-ready build, commonly an Android App Bundle.
- Use the correct signing configuration and secure your signing keys.
- Verify proguard, minification, and crash behavior before shipping.

## Google Play steps
- Create or update the release in the Play Console.
- Upload the bundle, complete required forms, and review policy declarations.
- Choose a testing or production track and submit.

## Rollout strategy
- Internal, closed, or open testing can reduce launch risk.
- Staged rollout helps monitor issues before reaching all users.
- Crash and ANR monitoring should continue after release.

## Common mistakes
- Shipping without enough testing.
- Forgetting version updates or store asset checks.
- Ignoring Play policy and data safety requirements.

## Example
```kotlin
android {
  defaultConfig {
    versionCode = 12
    versionName = "1.3.0"
  }
}
```

## Practice

1. Create a release checklist for your app before your next Play upload.
2. Verify versioning, signing, and store assets together before building.
3. Use a testing track before rolling out widely.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Kotlin language docs: https://kotlinlang.org/docs/home.html
