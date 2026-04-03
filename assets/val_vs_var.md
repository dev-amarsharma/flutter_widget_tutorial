# val vs var in Kotlin

## Overview
val vs var in Kotlin is a key topic for building reliable Android apps with Kotlin and Jetpack Compose.

## Learning goals
- Understand what val vs var in Kotlin solves.
- Know when to apply it in production code.
- Avoid common implementation mistakes.

## Key points
- Start simple and keep responsibilities focused.
- Prefer predictable state/data flow.
- Validate behavior with tests and small iterations.

## Example
```kotlin
fun demo(input: String): String {
    return input.trim()
}
```

## Common mistakes
- Overcomplicating the first implementation.
- Skipping edge cases and error handling.
- Not measuring behavior (performance/tests) when needed.

## Official references
- Primary: https://kotlinlang.org/docs/basic-syntax.html#variables
- Android docs hub: https://developer.android.com/
- Kotlin docs hub: https://kotlinlang.org/docs/home.html
