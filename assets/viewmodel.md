# ViewModel

## Overview
A `ViewModel` holds and manages UI-related state and business logic. Its defining feature is **lifecycle awareness**: a ViewModel survives configuration changes such as screen rotation, so the data it holds is not lost when the Activity or Fragment is recreated.

Android's official docs recommend the ViewModel as the place to store screen state, keeping that logic out of Activities, Fragments, and composables.

## Why it exists
When a device rotates, the Activity is destroyed and recreated. State kept inside the Activity (or in `remember`) is lost. A ViewModel is scoped to the screen, not the Activity instance, so it persists across that recreation and is cleared only when the screen is permanently gone.

## A basic ViewModel
```kotlin
class CounterViewModel : ViewModel() {
  private val _count = MutableStateFlow(0)
  val count: StateFlow<Int> = _count.asStateFlow()

  fun increment() {
    _count.value += 1
  }
}
```

The mutable state is kept private; the UI observes a read-only `StateFlow`. Events (like `increment()`) flow up into the ViewModel, which updates state that flows back down.

## Using it from Compose
```kotlin
@Composable
fun CounterScreen(viewModel: CounterViewModel = viewModel()) {
  val count by viewModel.count.collectAsStateWithLifecycle()

  Button(onClick = viewModel::increment) {
    Text("Count: $count")
  }
}
```

`viewModel()` retrieves (or creates) the correctly scoped instance, and `collectAsStateWithLifecycle()` observes the flow safely with the lifecycle.

## viewModelScope
A ViewModel exposes `viewModelScope`, a `CoroutineScope` that is automatically cancelled when the ViewModel is cleared. Use it for asynchronous work so nothing leaks:

```kotlin
fun load() {
  viewModelScope.launch {
    _count.value = repository.fetchCount()
  }
}
```

## What does not belong in a ViewModel
A ViewModel must not hold references to views, `Context`-bound objects, or anything tied to the Activity lifecycle, because that outlives the view and causes memory leaks. Pass an `Application` via `AndroidViewModel` only when you genuinely need application context.

## Best practices
- Expose read-only state (`StateFlow`/`State`) and keep mutable state private.
- Launch async work in `viewModelScope` so it is cancelled automatically.
- Keep UI logic in the ViewModel and rendering in the composable.
- Let the ViewModel survive configuration changes instead of saving everything manually.

## Common mistakes
- Holding a reference to a View, Activity, or Context in the ViewModel.
- Creating a ViewModel with its constructor instead of `viewModel()`/a factory.
- Running coroutines in a scope that is not cancelled with the ViewModel.
- Putting business logic directly inside composables or Activities.

## References
- ViewModel overview: https://developer.android.com/topic/libraries/architecture/viewmodel
- ViewModels and Compose: https://developer.android.com/develop/ui/compose/state#viewmodels-source-of-truth
