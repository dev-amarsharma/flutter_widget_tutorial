# Multiple Navigation Graphs

## Overview
Multiple navigation graphs in Compose help separate navigation flows such as authentication, onboarding, and main app content. This keeps route structure cleaner and easier to manage as the app grows.

## Why use multiple graphs
- Different app flows often have different start destinations and lifecycle expectations.
- Separating graphs makes navigation logic easier to reason about.
- It becomes easier to test and maintain feature-specific routes.

## Common examples
- An auth graph for login, signup, and forgot password.
- A main graph for home, profile, and settings.
- An onboarding graph shown only to first-time users.

## Compose approach
- Use a root `NavHost` and nest graph builders or route groups inside it.
- Navigate between graph roots when the user changes app state, such as logging in.

## Benefits
- Cleaner route organization.
- More modular navigation code.
- Better support for feature-based separation in multimodule apps.

## Common mistakes
- Putting every route in one giant graph file.
- Using inconsistent route naming across graphs.
- Not clearing back stack correctly when switching major flows.

## Example
```kotlin
NavHost(navController, startDestination = "auth") {
  navigation(startDestination = "login", route = "auth") {
    composable("login") { LoginScreen() }
    composable("signup") { SignupScreen() }
  }

  navigation(startDestination = "home", route = "main") {
    composable("home") { HomeScreen() }
    composable("settings") { SettingsScreen() }
  }
}
```

## Practice

1. Split one large navigation file into auth and main graphs.
2. Name graph roots clearly, such as `auth` and `main`.
3. Test back stack behavior when moving from auth to main content.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Navigation Compose guide: https://developer.android.com/jetpack/compose/navigation
