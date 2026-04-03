# Using Context in Android

## Overview
`Context` is one of the fundamental Android types. It gives access to app-specific resources and operations such as:

- resources
- system services
- starting activities and services
- file and preference APIs

Both `Activity` and `Application` are subclasses of `Context`, but they are not interchangeable in every situation.

## Activity context vs application context
Common distinction:

- activity context is tied to a specific screen and UI lifecycle
- application context is tied to the app process

Use activity context when:

- UI theming matters
- inflating or creating UI objects tied to the current screen
- launching screen-specific behavior

Use application context when:

- work should outlive one screen
- you need a process-wide context for non-UI operations

## Why misuse is risky
Using the wrong context can cause:

- memory leaks
- stale resources or configuration assumptions
- UI behavior that does not match the current activity state

Android’s `Context` reference also shows that some context types are not UI contexts and should not be used for UI-specific services.

## Examples
Good application-context use:

```kotlin
val appContext = applicationContext
val prefs = appContext.getSharedPreferences("settings", Context.MODE_PRIVATE)
```

Good activity-context use:

```kotlin
AlertDialog.Builder(this)
  .setTitle("Sign out?")
  .setPositiveButton("Yes", null)
  .show()
```

## Best practices
- Pass the narrowest context needed.
- Prefer application context for long-lived non-UI objects.
- Prefer activity context for UI and theming-sensitive work.
- Avoid storing activity context in long-lived singletons.

## Common mistakes
- Keeping a reference to an activity context in a singleton or repository.
- Using application context for UI that needs activity theming or window behavior.
- Treating all context instances as identical.

## References
- Context API reference: https://developer.android.com/reference/android/content/Context
- Introduction to activities: https://developer.android.com/guide/components
