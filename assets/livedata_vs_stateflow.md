# LiveData vs StateFlow

## Overview
Both LiveData and StateFlow can expose observable UI state, but they come from different ecosystems. Android's official guidance describes `StateFlow` as a state-holder observable flow that emits the current and new state to collectors, and it positions StateFlow as a strong fit for classes that maintain observable mutable state.

## LiveData
LiveData is part of Android's lifecycle-aware architecture components. It is commonly used in older View-based MVVM code and automatically respects `LifecycleOwner` observation patterns.

## StateFlow
StateFlow belongs to Kotlin Flow. Key points from Android's docs:

- it is hot
- it always has a current value
- the current value is readable via `.value`
- `MutableStateFlow.value = ...` updates and emits state

Because it is based on Flow, it works naturally with coroutines and Compose collection APIs.

## Practical comparison
- LiveData is lifecycle-aware by design for traditional observation APIs.
- StateFlow integrates better with coroutines, Flow operators, and modern Compose patterns.
- StateFlow requires collection, often through lifecycle-aware helpers in Android UI layers.

## When to prefer StateFlow
In modern Android code, StateFlow is often preferred for ViewModel UI state because it works well with coroutines and survives configuration changes when exposed from a ViewModel.

## Common mistakes
- Assuming LiveData and StateFlow are identical.
- Forgetting that StateFlow is hot and always has a current value.
- Mixing patterns without a clear architecture reason.

## References
- StateFlow and SharedFlow on Android: https://developer.android.com/kotlin/flow/stateflow-and-sharedflow
