# Crashlytics

## Overview
Firebase Crashlytics is Google’s crash reporting solution for Android and other platforms. The official docs describe it as a way to capture and analyze:

- crashes
- non-fatal errors
- ANRs

Crashlytics groups issues and helps teams prioritize the most impactful stability problems.

## What it provides
From the official Android docs and API reference:

- automatic crash capture after setup
- non-fatal exception recording
- ANR reporting
- custom keys for added debugging context
- checks for unsent reports if collection is disabled

## Example
```kotlin
val crashlytics = FirebaseCrashlytics.getInstance()
crashlytics.setCustomKey("screen", "checkout")

try {
  riskyOperation()
} catch (t: Throwable) {
  crashlytics.recordException(t)
}
```

This records a non-fatal issue with extra context for debugging.

## Best practices
- Add meaningful custom keys around critical flows.
- Record non-fatal exceptions for recoverable but important failures.
- Combine Crashlytics with Analytics breadcrumbs when appropriate.
- Use issue impact and frequency to prioritize fixes.

## Common mistakes
- Logging every minor validation issue as a crash signal.
- Sending no context, making reports harder to debug.
- Treating Crashlytics as a replacement for local testing.

## References
- Crashlytics for Android get started: https://firebase.google.com/docs/crashlytics/android/get-started
- FirebaseCrashlytics Android API: https://firebase.google.com/docs/reference/android/com/google/firebase/crashlytics/FirebaseCrashlytics
- Crashlytics overview: https://firebase.google.com/docs/crashlytics
