# Navigation Arguments

## Overview
Navigation arguments are values passed from one destination to another in a navigation flow. In Navigation Compose, they are useful for sending identifiers, filters, or simple screen parameters between composables.

## Why use arguments
- A detail screen often needs an item ID or slug.
- A search screen may need an initial query or filter.
- Arguments help destinations render context-specific content.

## Compose approach
- Define route placeholders such as `detail/{itemId}`.
- Declare matching nav arguments when needed.
- Read values from the back stack entry inside the destination.

## Good practices
- Pass only lightweight identifiers or simple parameters.
- Load heavy objects from repositories using the argument value.
- Keep route formats consistent and easy to debug.

## Common mistakes
- Passing large complex objects through routes.
- Using unclear route names or mismatched argument keys.
- Forgetting to encode special characters when needed.

## Example
```kotlin
composable(
  route = "detail/{userId}",
  arguments = listOf(navArgument("userId") { type = NavType.StringType })
) { backStackEntry ->
  val userId = backStackEntry.arguments?.getString("userId")
  DetailScreen(userId = userId.orEmpty())
}
```

## Practice

1. Pass an item ID from a list screen to a detail screen.
2. Replace one heavy argument object with a repository lookup by ID.
3. Check whether special characters need route encoding in your app.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Navigation Compose guide: https://developer.android.com/jetpack/compose/navigation
