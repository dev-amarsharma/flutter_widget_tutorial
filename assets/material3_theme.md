# Material 3 Theme

## Overview
Compose Material 3 uses `MaterialTheme` to provide app-wide design values. Android's Material 3 docs describe three main theme subsystems: `colorScheme`, `typography`, and `shapes`. When you customize these, Material 3 components reflect those changes automatically.

## Basic theme structure

```kotlin
MaterialTheme(
  colorScheme = lightColorScheme(),
  typography = Typography(),
  shapes = Shapes()
) {
  AppContent()
}
```

You can then read current theme values with:

- `MaterialTheme.colorScheme`
- `MaterialTheme.typography`
- `MaterialTheme.shapes`

## Color scheme
The docs emphasize role-based colors such as `primary`, `onPrimary`, `secondary`, `surface`, and others. Components use these roles rather than arbitrary colors so the UI stays consistent.

Material 3 also supports dynamic color on supported Android versions through `dynamicLightColorScheme(...)` and `dynamicDarkColorScheme(...)`.

## Typography and shapes
- typography defines text styles such as body, title, and headline roles
- shapes define corner treatments and overall surface shape style

## Best practices
- Centralize theme definitions in one app theme layer.
- Prefer theme roles over hard-coded colors.
- Use `MaterialTheme` values in components so the design stays consistent.
- Support dark theme and dynamic color when appropriate.

## Common mistakes
- Hard-coding colors in many individual composables.
- Ignoring typography and shape systems while only changing colors.
- Mixing Material 2 and Material 3 assumptions without care.

## References
- Material Design 3 in Compose: https://developer.android.com/develop/ui/compose/designsystems/material3
- MaterialTheme API: https://developer.android.com/reference/kotlin/androidx/compose/material3/MaterialTheme
