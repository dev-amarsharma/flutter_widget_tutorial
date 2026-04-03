# Android Permissions

## Overview
Android permissions protect access to sensitive capabilities such as camera, location, notifications, storage, and contacts. Modern Android apps must request dangerous permissions at runtime when the feature is actually needed.

## Permission categories
- Normal permissions are granted automatically at install time.
- Dangerous permissions require runtime approval from the user.
- Special permissions have their own platform-specific flows.

## Runtime flow
- Declare the permission in the manifest when required.
- Request it at runtime near the moment the feature is used.
- Handle granted, denied, and permanently denied states clearly.

## UX best practices
- Ask only for permissions tied to a clear user action.
- Explain why the permission is needed in simple language when helpful.
- Provide fallback behavior when the user declines.

## Compose relevance
- Compose screens still follow Android’s permission model.
- Permission state should be reflected clearly in UI state and behavior.

## Common mistakes
- Requesting too many permissions up front.
- Giving no context for why access is needed.
- Failing to handle denial gracefully.

## Example
```kotlin
if (hasCameraPermission) {
  openCamera()
} else {
  requestCameraPermission()
}
```

## Practice

1. Audit one feature and request its permission only when needed.
2. Design a denied-state UI for one sensitive capability.
3. Review whether any manifest permissions are no longer necessary.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Kotlin language docs: https://kotlinlang.org/docs/home.html
