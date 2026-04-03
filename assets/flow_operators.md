# Flow Operators

## Overview
Flow operators transform, combine, and consume streams. The Kotlin docs separate them into:

- intermediate operators
- terminal operators

Intermediate operators transform an upstream flow and return a downstream flow. Terminal operators trigger collection.

## Intermediate operators
Common intermediate operators include:

- `map`
- `filter`
- `transform`
- `zip`
- `combine`
- flattening operators like `flatMapConcat` and `flatMapMerge`

These are cold just like flows themselves. Calling them builds a new pipeline; it does not start execution.

## Terminal operators
Common terminal operators include:

- `collect`
- `toList`
- `first`
- `single`
- `reduce`
- `fold`

These actually start collection.

## Example
```kotlin
(1..5).asFlow()
  .filter { it % 2 == 0 }
  .map { "value $it" }
  .collect { println(it) }
```

## Best practices
- Keep operator chains readable.
- Use intermediate operators for transformation and terminal operators for final consumption.
- Choose flattening and combination operators based on intended concurrency and ordering.

## Common mistakes
- Thinking `map` or `filter` starts the flow.
- Building chains that are hard to reason about.
- Choosing merge behavior without understanding ordering semantics.

## References
- Kotlin Flow: https://kotlinlang.org/docs/flow.html
