# Icons in Compose

## Overview
The `Icon` composable is the standard way to draw a single-color icon in Compose following Material styling. Android’s docs explain that `Icon` applies Material defaults such as tinting and size.

By default:

- the tint uses `LocalContentColor.current`
- the size is `24.dp`

## Icon sources
Android documents several common icon sources:

- vector drawables loaded with `painterResource(...)`
- predefined Material icon sets via `Icons`

Example:

```kotlin
Icon(
  painter = painterResource(R.drawable.baseline_directions_bus_24),
  contentDescription = stringResource(R.string.bus_content_description)
)
```

## Material icons note
Android’s newer guidance says the old `androidx.compose.material.icons` Material Icons library is no longer the recommended forward path. Material Symbols via downloaded vector drawable XML from Google Fonts are the recommended modern approach for up-to-date icon styling.

However, the `Icons` object still exists and is widely used in many codebases.

## Best practices
- Use meaningful `contentDescription` for accessible actionable icons.
- Keep icon style consistent across the app.
- Prefer `Image` instead of `Icon` when you need more customization than a standard small icon.
- Consider Material Symbols for current icon styling guidance.

## Common mistakes
- Omitting accessibility descriptions for meaningful icons.
- Mixing many unrelated icon styles.
- Using the old icon library without awareness of the newer Material Symbols guidance.

## References
- Icons in Compose: https://developer.android.com/develop/ui/compose/graphics/images/material
- Resources in Compose: https://developer.android.com/jetpack/compose/resources
- Icons API reference: https://developer.android.com/reference/kotlin/androidx/compose/material/icons/Icons
