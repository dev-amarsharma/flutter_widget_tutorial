# Error Handling in Flow

## Overview
Kotlin Flow can complete with an exception when code in the emitter, intermediate operators, or collector throws. The official Kotlin Flow docs describe several ways to handle these exceptions.

At a high level, you can handle errors:

- imperatively with `try/catch` around `collect`
- declaratively with operators such as `catch`
- with completion handling via `onCompletion`

## Collector-side `try/catch`
One simple pattern:

```kotlin
try {
  flow.collect { value ->
    println(value)
  }
} catch (t: Throwable) {
  println("Caught $t")
}
```

This catches failures from the flow pipeline.

## Using `catch`
The `catch` operator lets you handle upstream exceptions declaratively:

```kotlin
flow
  .catch { e ->
    emit(fallbackValue)
  }
  .collect { value ->
    render(value)
  }
```

This is useful for transforming errors into fallback UI data or domain results.

## Completion
The Kotlin docs also describe `onCompletion`, which runs when flow collection completes normally or exceptionally. It is useful for cleanup or state updates that should happen regardless of success.

## Best practices
- Decide whether errors should be surfaced, retried, or converted to fallback values.
- Keep error handling consistent with UI state modeling.
- Use `catch` for upstream transformation and `try/catch` when imperative handling is clearer.
- Avoid swallowing exceptions silently.

## Common mistakes
- Ignoring exceptions entirely.
- Catching errors and emitting meaningless fallback data that hides real problems.
- Mixing UI rendering concerns directly into low-level flow builders.

## References
- Kotlin Flow: https://kotlinlang.org/docs/flow.html
