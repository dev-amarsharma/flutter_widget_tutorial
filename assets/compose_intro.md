# Jetpack Compose Introduction

## Overview
Jetpack Compose is Android’s modern toolkit for building native UI with Kotlin. Android Developers describes Compose as a declarative toolkit that simplifies and accelerates UI development.

Instead of defining UI in XML and mutating views imperatively, Compose lets you describe the UI directly in Kotlin with composable functions.

## Why Compose matters
Compose aims to improve:

- UI development speed
- consistency of state-driven UI
- code readability
- reuse across Android form factors

Android positions Compose as the recommended modern UI toolkit for Android development.

## Key ideas
Compose transforms state into UI through:

- composition
- layout
- drawing

A composable function takes data and emits UI. When the state changes, Compose recomposes the affected parts of the tree.

## Example
```kotlin
setContent {
  MaterialTheme {
    Greeting("Android")
  }
}
```

```kotlin
@Composable
fun Greeting(name: String) {
  Text("Hello $name")
}
```

## Best practices
- Learn the declarative model early.
- Keep state outside UI where appropriate and pass it in.
- Build screens from small composables.
- Use Material components and theme roles consistently.

## Common mistakes
- Thinking in terms of mutating old view hierarchies.
- Putting too much stateful logic directly into UI functions.
- Ignoring recomposition and state flow.

## References
- Develop UI with Compose: https://developer.android.com/develop/ui
- Android Compose tutorial: https://developer.android.com/develop/ui/compose/tutorial
- Thinking in Compose: https://developer.android.com/jetpack/compose/mental-model
