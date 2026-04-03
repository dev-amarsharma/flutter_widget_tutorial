# Colors in Compose

## Overview
Compose Material 3 uses color schemes rather than scattered hardcoded colors. Android’s Material 3 guidance centers around `colorScheme`, which groups semantic colors used throughout the UI.

Common color roles include:

- `primary`
- `secondary`
- `tertiary`
- `background`
- `surface`
- `error`
- matching “on” colors such as `onPrimary` and `onSurface`

## Why semantic color roles matter
Semantic colors let the UI stay consistent and adaptable across:

- light mode
- dark mode
- dynamic color on supported devices

Instead of choosing random hex values everywhere, components consume theme roles.

## Example
```kotlin
MaterialTheme(
  colorScheme = lightColorScheme(
    primary = Color(0xFF0061A4),
    onPrimary = Color.White,
    surface = Color.White,
    onSurface = Color(0xFF1A1C1E)
  )
) {
  AppContent()
}
```

## Best practices
- Prefer `MaterialTheme.colorScheme` roles over hardcoded colors in component code.
- Define both content and container roles clearly.
- Test the UI in both light and dark themes.
- Use dynamic color when it fits the product and platform support.

## Common mistakes
- Hardcoding colors inside many composables.
- Ignoring contrast between container and content colors.
- Treating `primary` as the only important color role.

## References
- Material 3 in Compose: https://developer.android.com/develop/ui/compose/designsystems/material3
- Design systems in Compose: https://developer.android.com/develop/ui/compose/designsystems
