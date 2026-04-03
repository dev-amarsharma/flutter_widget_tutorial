# collectAsState

## Overview
Compose needs observable state to know when to recompose. Android’s state documentation explains that when you want to read values from other observable types, you convert them to `State<T>` first.

For `Flow`, Compose provides:

- `collectAsStateWithLifecycle()` for Android apps
- `collectAsState()` for platform-agnostic Compose code

`collectAsState()` collects a `Flow` and exposes the latest value as Compose `State`.

## Why it matters
Without converting the stream into Compose state, your composable cannot automatically recompose when the data changes.

This makes `collectAsState` a bridge between:

- coroutine-based reactive streams
- state-driven Compose UI

## Example
```kotlin
@Composable
fun TaskCount(viewModel: TasksViewModel) {
  val count by viewModel.taskCountFlow.collectAsState(initial = 0)
  Text("Tasks: $count")
}
```

When `taskCountFlow` emits a new value, the composable sees updated state and recomposes.

## `collectAsState` vs `collectAsStateWithLifecycle`
Android’s docs recommend:

- use `collectAsStateWithLifecycle()` in Android UI code so collection respects lifecycle and conserves resources
- use `collectAsState()` for platform-agnostic code or when lifecycle-aware collection is not the goal

## Best practices
- Prefer `collectAsStateWithLifecycle()` in Android app screens.
- Use `collectAsState()` for multiplatform or runtime-only Compose code.
- Keep flows in `ViewModel` or state-holder layers rather than creating them inside composables.
- Expose UI-friendly state streams from the `ViewModel`.

## Common mistakes
- Collecting flows manually in composables when state conversion would be simpler.
- Starting expensive stream logic directly in the composable body.
- Forgetting to provide an initial value when needed.
- Using platform-specific lifecycle collection in shared code.

## References
- State in Compose: https://developer.android.com/develop/ui/compose/state
- Where to hoist state: https://developer.android.com/jetpack/compose/state-hoisting
