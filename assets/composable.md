# Composable Functions

## Overview
Composable functions are the basic building blocks of Jetpack Compose. Android’s Compose tutorial explains that you create one by annotating a function with `@Composable`.

A composable function describes UI by taking input data and emitting UI elements.

## Core characteristics
Android’s “Thinking in Compose” guidance highlights that composable functions should be:

- fast
- idempotent
- free of side effects

They do not return view objects. Instead, they describe what the UI should look like for the current state.

## Example
```kotlin
@Composable
fun Greeting(name: String) {
  Text("Hello $name")
}
```

This function:

- is annotated with `@Composable`
- takes input data
- emits UI by calling another composable

## Declarative UI model
Compose is declarative. Instead of mutating view objects manually, you call composables again with new state. Compose then recomposes the parts of the UI that need updating.

That means composables should avoid:

- mutating shared state during composition
- performing heavy work directly in the composable body
- depending on execution order side effects

## Best practices
- Make composables small and focused.
- Pass state down and events up.
- Keep them side-effect free unless using dedicated effect APIs.
- Use parameters to describe UI state clearly.

## Common mistakes
- Treating composables like imperative view builders.
- Writing side effects directly in the composable body.
- Doing expensive work during composition instead of in state holders or effects.

## References
- Android Compose tutorial: https://developer.android.com/develop/ui/compose/tutorial
- Thinking in Compose: https://developer.android.com/jetpack/compose/mental-model
