# Mutable State

## Overview
Mutable state in Jetpack Compose represents data that can change over time and trigger recomposition when updated. It is one of the core ideas behind reactive UI in Compose.

## What it means
- State is data the UI reads to decide what to display.
- Mutable state is state that can be updated, causing dependent composables to recompose.

## Common APIs
- `mutableStateOf()` creates observable state.
- `remember` keeps state across recompositions within the same composition.
- `rememberSaveable` can preserve simple UI state across recreation when supported.

## Why it matters
- Compose UI should be driven by state rather than manual view mutation.
- When state changes, Compose updates only the parts of the UI that depend on it.

## Best practices
- Hoist state upward when multiple composables need it.
- Prefer immutable UI models where possible and mutate through controlled state holders.
- Keep business logic out of low-level composables.

## Common mistakes
- Using ordinary variables instead of observable state.
- Keeping too much state deep in the UI tree.
- Mutating shared objects in ways Compose cannot observe clearly.

## Example
```kotlin
@Composable
fun Counter() {
  var count by remember { mutableStateOf(0) }
  Button(onClick = { count++ }) {
    Text("Count: $count")
  }
}
```

## Practice

1. Convert one ordinary variable into Compose state with `remember { mutableStateOf(...) }`.
2. Hoist one piece of shared state to a parent composable.
3. Decide whether a given value belongs in `remember`, `rememberSaveable`, or a ViewModel.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Navigation Compose guide: https://developer.android.com/jetpack/compose/navigation
