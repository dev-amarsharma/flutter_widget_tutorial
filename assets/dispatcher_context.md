# Coroutine Dispatchers and Context

## Overview
Coroutine dispatchers determine which thread or thread pool executes coroutine work. Android’s coroutine docs explain three common dispatchers:

- `Dispatchers.Main`
- `Dispatchers.IO`
- `Dispatchers.Default`

Coroutine context is broader. It can include:

- dispatcher
- job
- name
- exception handler

Android’s coroutine learning materials describe `CoroutineContext` as a map of such elements.

## Common dispatchers
Use:

- `Dispatchers.Main` for UI-related work and quick main-thread tasks
- `Dispatchers.IO` for disk and network I/O
- `Dispatchers.Default` for CPU-intensive computations

## Main-safety
Android explicitly recommends making long-running or blocking work main-safe. A typical pattern is:

```kotlin
suspend fun loadNews(): News = withContext(Dispatchers.IO) {
  api.fetchNews()
}
```

This keeps callers free to start from the main thread without blocking UI updates.

## Context inheritance
Child coroutines inherit context from their parent scope, though some parts such as the job are replaced with child-specific instances.

That inheritance is one reason structured concurrency works well.

## Best practices
- Pick dispatchers based on the nature of the work.
- Inject dispatchers in production code when testability matters.
- Use `withContext` to move blocking work off the main thread.
- Prefer lifecycle-aware scopes in Android app layers.

## Common mistakes
- Running blocking I/O on `Dispatchers.Main`.
- Hardcoding dispatchers everywhere, making tests harder.
- Confusing scope ownership with dispatcher choice.

## References
- Kotlin coroutines on Android: https://developer.android.com/kotlin/coroutines
- Improve app performance with coroutines: https://developer.android.com/kotlin/coroutines/coroutines-adv
- Coroutines best practices: https://developer.android.com/kotlin/coroutines/coroutines-best-practices
