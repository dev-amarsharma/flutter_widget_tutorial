# State in Compose

## Overview
State is any value that can change over time and that your UI reads. In Jetpack Compose, the UI is a function of state: when state changes, Compose **recomposes** the affected composables and redraws them with the new values.

Android's official docs describe this as a one-way flow: state flows down into composables, and events flow up to change that state.

## remember and mutableStateOf
A plain Kotlin variable will not trigger recomposition. You need observable state created with `mutableStateOf`, kept across recompositions with `remember`:

```kotlin
@Composable
fun Counter() {
  var count by remember { mutableStateOf(0) }

  Button(onClick = { count++ }) {
    Text("Clicked $count times")
  }
}
```

- `mutableStateOf` creates a value Compose can observe.
- `remember` stores it so it survives recomposition.
- `by` lets you read and write `count` directly instead of `count.value`.

## Surviving configuration changes
`remember` is cleared when the composable leaves the composition or the screen rotates. Use `rememberSaveable` to keep simple state across configuration changes such as rotation:

```kotlin
var name by rememberSaveable { mutableStateOf("") }
```

## State hoisting
A composable that owns its own state is hard to reuse and test. **State hoisting** moves the state up to the caller, turning the child into a stateless composable that receives a value and a callback:

```kotlin
@Composable
fun NameField(
  name: String,
  onNameChange: (String) -> Unit
) {
  TextField(value = name, onValueChange = onNameChange)
}
```

The parent owns `name` and passes it down; the field reports changes up. This is the "state down, events up" pattern.

## Where state should live
Keep state at the lowest common ancestor that needs it. For UI-only state (such as whether a menu is expanded), `remember` inside a composable is fine. For screen-level or business state, hoist it to a `ViewModel` so it survives recomposition and configuration changes.

## Best practices
- Use `mutableStateOf` with `remember` for observable UI state.
- Use `rememberSaveable` for state that must survive rotation.
- Hoist state so composables stay stateless and reusable.
- Keep state as close as possible to where it is used, and no closer.

## Common mistakes
- Mutating a normal variable and expecting the UI to update.
- Forgetting `remember`, so state resets on every recomposition.
- Storing large or screen-level state inside a deeply nested composable.
- Hoisting everything to the top, creating unnecessary coupling.

## References
- State and Jetpack Compose: https://developer.android.com/develop/ui/compose/state
- State hoisting: https://developer.android.com/develop/ui/compose/state-hoisting
