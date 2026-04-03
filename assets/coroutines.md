# Coroutines

## Overview
Coroutines are Kotlin’s lightweight solution for asynchronous and concurrent programming. Kotlin’s official documentation describes a coroutine as a suspendable computation that lets you write concurrent code in a clear, sequential style.

Android Developers recommends coroutines as the preferred solution for asynchronous programming on Android.

## Why coroutines matter
Coroutines help you:

- avoid blocking the main thread
- express async work with sequential-looking code
- structure concurrent tasks safely
- handle cancellation more predictably

Compared with raw threads, coroutines are much lighter and can suspend without blocking the underlying thread.

## Key concepts
Important coroutine concepts include:

- `suspend` functions
- `CoroutineScope`
- builders like `launch` and `async`
- dispatchers such as `Dispatchers.Main`, `Dispatchers.IO`, and `Dispatchers.Default`
- structured concurrency

## Example
```kotlin
viewModelScope.launch {
  val articles = repository.loadArticles()
  _uiState.value = UiState.Success(articles)
}
```

This launches asynchronous work without blocking the main thread and ties the work to a lifecycle-aware scope.

## Structured concurrency
Kotlin’s docs emphasize structured concurrency:

- coroutines belong to a scope
- parent and child lifecycles are connected
- cancellation and failure behavior become more predictable

This is a major reason coroutines are safer than launching unbounded background work.

## Best practices
- Use lifecycle-aware scopes in Android UI layers.
- Make long-running or blocking work main-safe.
- Prefer `suspend` functions and clear structured scopes over ad hoc thread management.
- Use the right dispatcher for the job.

## Common mistakes
- Launching work in unmanaged global scopes.
- Blocking the main thread inside coroutine code.
- Ignoring cancellation and error propagation.

## References
- Kotlin coroutines overview: https://kotlinlang.org/docs/coroutines-overview.html
- Coroutines basics: https://kotlinlang.org/docs/coroutines-basics.html
- Kotlin coroutines on Android: https://developer.android.com/kotlin/coroutines
