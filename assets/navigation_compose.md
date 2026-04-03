# Navigation Compose

## Overview
Navigation Compose is the Jetpack navigation library built for composable destinations instead of Fragment-based screens. It provides route-based navigation, back stack handling, and argument support for Compose apps.

## What it provides
- Route-based screen navigation for Compose.
- Back stack management through NavController.
- Destination arguments, nested graphs, and deep-link-friendly structure.

## Core building blocks
- `rememberNavController()` creates the navigation controller.
- `NavHost` hosts destinations.
- `composable` declares route screens.

## Why it fits Compose
- It keeps navigation in the declarative UI world.
- Destinations are composable functions rather than fragments.
- It works naturally with ViewModels and state-driven UI.

## Best practices
- Use stable route definitions and constants.
- Pass lightweight arguments.
- Split large graphs as the app grows.

## Common mistakes
- Treating route strings as unstructured magic text everywhere.
- Passing heavy objects through routes.
- Keeping all navigation code tangled in one file.

## Example
```kotlin
val navController = rememberNavController()

NavHost(navController = navController, startDestination = "home") {
  composable("home") {
    HomeScreen(onOpenProfile = { navController.navigate("profile") })
  }
  composable("profile") {
    ProfileScreen()
  }
}
```

## Practice

1. Add Navigation Compose to a small sample app with two routes.
2. Refactor hardcoded route strings into constants or typed wrappers.
3. Review whether your graph should be split into multiple flows.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Navigation Compose guide: https://developer.android.com/jetpack/compose/navigation
