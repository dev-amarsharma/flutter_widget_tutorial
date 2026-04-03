# Coroutines Introduction

## Overview
Coroutines are Kotlin’s modern approach to writing asynchronous code. Kotlin’s official docs explain that applications often need concurrency so tasks like user input, data loading, and UI updates can happen without blocking one another.

Coroutines let you express that concurrency with sequential-looking code.

## Basic building blocks
If you are new to coroutines, focus first on:

- `suspend` functions
- scopes
- builders like `launch`
- dispatchers

You do not need to learn every coroutine API at once to become productive.

## First example
```kotlin
suspend fun loadGreeting(): String {
  delay(500)
  return "Hello"
}
```

```kotlin
scope.launch {
  val greeting = loadGreeting()
  println(greeting)
}
```

The `delay()` call suspends the coroutine without blocking the thread.

## Coroutines vs threads
Kotlin’s docs explain that threads are managed by the operating system and are relatively expensive, while coroutines are lighter and can share thread pools more efficiently.

This makes coroutines a better fit for fine-grained asynchronous app work.

## Android view
On Android, coroutines are especially useful for:

- repository loading
- network requests
- database operations
- state updates tied to lifecycle-aware scopes

## Best practices
- Start with suspend functions and one clear scope.
- Learn cancellation and dispatcher usage early.
- Keep async logic structured, not scattered across random global launches.

## Common mistakes
- Thinking coroutines are the same as raw threads.
- Assuming suspension blocks the thread.
- Starting many coroutines without a clear owning scope.

## References
- Coroutines overview: https://kotlinlang.org/docs/coroutines-overview.html
- Coroutines basics: https://kotlinlang.org/docs/coroutines-basics.html
