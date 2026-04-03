# NavHost

## Overview
NavHost is the Compose container that displays the current navigation destination based on the navigation state. It connects a NavController with the graph of composable routes.

## Role of NavHost
- It defines where destination content appears on screen.
- It maps routes to composable screens.
- It works together with the NavController to change visible destinations.

## Basic pieces
- A remembered `NavController` manages navigation actions and back stack.
- `NavHost` declares the start destination and route graph.
- `composable(...)` blocks define individual destinations.

## Why it matters
- It is the central navigation container in Navigation Compose.
- Without it, route definitions and screen switching are not connected.

## Best practices
- Keep route names clear and stable.
- Organize graph-building code as the app grows.
- Avoid putting unrelated business logic inside navigation setup.

## Example
```kotlin
@Composable
fun AppNavigation() {
  val navController = rememberNavController()

  NavHost(navController = navController, startDestination = "home") {
    composable("home") { HomeScreen(navController) }
    composable("profile") { ProfileScreen() }
  }
}
```

## Practice

1. Create a small NavHost with two routes.
2. Extract route constants so names stay consistent.
3. Move growing route declarations into helper graph functions.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Navigation Compose guide: https://developer.android.com/jetpack/compose/navigation
