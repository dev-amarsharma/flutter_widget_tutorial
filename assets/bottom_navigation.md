# Bottom Navigation

## Overview
In Compose Material 3, bottom navigation is implemented with `NavigationBar` and `NavigationBarItem`. Android Developers recommends a navigation bar for:

- three to five destinations of equal importance
- compact window sizes
- destinations that remain consistent across app screens

Material 3 renamed the old Material 2 bottom navigation component to navigation bar.

## Core APIs
Use:

- `NavigationBar`
- `NavigationBarItem`

Key `NavigationBarItem` parameters:

- `selected`
- `onClick`
- `icon`
- `label`

## Example
```kotlin
NavigationBar {
  destinations.forEach { destination ->
    NavigationBarItem(
      selected = currentRoute == destination.route,
      onClick = { navController.navigate(destination.route) },
      icon = { Icon(destination.icon, contentDescription = destination.label) },
      label = { Text(destination.label) }
    )
  }
}
```

## When to use it
Choose bottom navigation when users need to switch quickly between top-level destinations such as:

- Home
- Search
- Library
- Profile

If the app has more destinations or larger layouts, Android recommends considering components like `NavigationRail` or drawers depending on screen size.

## Best practices
- Keep it to three to five destinations.
- Use stable top-level destinations only.
- Reflect the current selected destination clearly.
- Pair navigation items with meaningful icons and optional labels.

## Common mistakes
- Using bottom navigation for deep drill-down screens.
- Putting too many items in the bar.
- Mixing transient actions with navigation destinations.
- Forgetting to manage the selected state correctly.

## References
- Navigation bar: https://developer.android.com/develop/ui/compose/components/navigation-bar
- Material 3 in Compose: https://developer.android.com/develop/ui/compose/designsystems/material3
- M2 to M3 navigation bar migration: https://developer.android.com/develop/ui/compose/designsystems/material2-material3
