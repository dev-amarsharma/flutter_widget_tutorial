# State Hoisting

## Overview
State Hoisting is a key topic for building reliable Android apps with Kotlin and Jetpack Compose.

## Learning goals
- Understand what State Hoisting solves.
- Know when to apply it in production code.
- Avoid common implementation mistakes.

## Key points
- Start simple and keep responsibilities focused.
- Prefer predictable state/data flow.
- Validate behavior with tests and small iterations.

## Example
```kotlin
@Composable
fun SampleScreen() {
    // Apply State Hoisting here.
}
```

## Common mistakes
- Overcomplicating the first implementation.
- Skipping edge cases and error handling.
- Not measuring behavior (performance/tests) when needed.

## Official references
- Primary: https://developer.android.com/develop/ui/compose/state-hoisting
- Android docs hub: https://developer.android.com/
- Kotlin docs hub: https://kotlinlang.org/docs/home.html
