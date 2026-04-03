# Dark Mode

## Overview
Dark theme is part of the Android system experience and is available on Android 10 and higher. Android Developers highlights several benefits:

- reduced power usage on some display technologies
- improved visibility for some users
- easier viewing in low-light environments

In modern Compose apps, dark mode is usually implemented through your theme and color scheme rather than ad hoc color toggles in individual composables.

## How Android dark theme works
Android supports dark theme through:

- system theme settings
- quick settings tile on supported devices
- battery saver behavior on some devices

Apps should respond appropriately to the system theme where possible.

## Compose approach
In Compose Material 3, you typically define:

- light color scheme
- dark color scheme

Then choose between them based on whether dark mode is active.

Example:

```kotlin
val colors = if (isSystemInDarkTheme()) {
  darkColorScheme()
} else {
  lightColorScheme()
}
```

## Best practices
- Use theme-level color schemes rather than hardcoded per-screen overrides.
- Verify readability and contrast in both light and dark themes.
- Treat dark mode as a first-class design state, not an afterthought.
- Test icons, surfaces, and text emphasis carefully.

## Common mistakes
- Hardcoding colors that look correct only in light mode.
- Ignoring contrast and accessibility.
- Assuming dark mode means simply inverting every color.

## References
- Implement dark theme: https://developer.android.com/develop/ui/views/theming/darktheme
- Material 3 in Compose: https://developer.android.com/develop/ui/compose/designsystems/material3
