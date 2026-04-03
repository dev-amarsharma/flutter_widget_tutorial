# Configuration Changes

## Overview
Configuration changes happen when device or system state changes while your app is running. Android’s official guide lists examples such as:

- screen orientation
- display size
- locale
- font size
- keyboard availability
- dark mode versus light mode

Many of these changes cause Android to recreate your `Activity` so the app can reload resources for the new configuration.

## Default behavior
In most cases, Android handles configuration changes by destroying and recreating the activity. This is the recommended default because the framework can automatically apply the correct resources for the new configuration.

That means your app must be prepared to:

- restore UI state
- avoid storing important screen state only in activity fields
- tolerate recreation cleanly

## Why it matters
If the app does not handle recreation correctly, users can lose:

- text input
- selected tabs
- scroll position
- in-progress UI context

Android recommends keeping important UI-related data in appropriate state holders and saving transient state as needed.

## `android:configChanges`
You can opt out of activity recreation for some changes by declaring `android:configChanges`, but Android explicitly warns that this is not recommended for most apps because the system no longer handles alternative resources for you automatically.

This should be a last resort, not a default strategy.

## Compose and configuration changes
The same core principle still applies in Compose:

- keep durable screen state outside the activity where appropriate
- restore transient UI state correctly
- design screens so recreation does not break user continuity

## Best practices
- Let the system recreate activities by default.
- Use `ViewModel` for longer-lived screen state.
- Save transient UI state that users expect to survive recreation.
- Test rotation, resizing, locale changes, and dark theme changes.

## Common mistakes
- Disabling recreation without fully handling resources and state manually.
- Keeping critical state only in activity instance fields.
- Testing only on portrait phone layouts.

## References
- Handle configuration changes: https://developer.android.com/guide/topics/resources/runtime-changes
- Configuration and continuity: https://developer.android.com/guide/topics/large-screens/configuration-and-continuity
