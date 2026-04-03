# APK vs AAB

## Overview
APK and AAB are not the same thing.

- APK is the installable Android app package that runs on a device.
- AAB, or Android App Bundle, is a publishing format that you upload to Google Play and some other stores.

According to Android Developers, Google Play uses an uploaded app bundle to generate optimized APKs for specific device configurations.

## Key difference
APK:

- installable on a device
- executable app package
- historically distributed directly

AAB:

- not directly installable on a device
- uploaded as a publishing artifact
- lets Play generate device-optimized APKs

## Why AAB matters
Android Developers states that app bundles help reduce download size because each user gets only the code and resources needed for their device. That usually means:

- smaller downloads
- less unused resource delivery
- simpler multi-APK management

## Official Android guidance
Important points from Android Developers:

- new Google Play apps have been required to publish with Android App Bundles since August 2021
- app bundles are open source and not exclusive to Google Play
- app bundles organize code and resources into modules that can be turned into base, feature, and configuration APKs

## Practical takeaway
Think of AAB as your publishing input and APK as the installable output.

If you use Play:

- build and upload an `.aab`
- Play generates optimized APKs per device

If you distribute elsewhere, the store or delivery process may differ, but the conceptual distinction still matters.

## Best practices
- Use AAB for Play publishing.
- Understand that AAB is not what users install directly.
- Keep asset and module organization clean because bundles are module-aware.
- Verify delivery behavior if you use dynamic features or asset delivery.

## Common mistakes
- Thinking AAB is just a renamed APK.
- Expecting to install an `.aab` directly on a phone like an APK.
- Forgetting that Play, not the developer, generates device-targeted APKs from the bundle.

## References
- About Android App Bundles: https://developer.android.com/guide/app-bundle
- Android App Bundle format: https://developer.android.com/guide/app-bundle/app-bundle-format
- Android App Bundle FAQ: https://developer.android.com/guide/app-bundle/faq
