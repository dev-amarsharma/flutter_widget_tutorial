# Lambdas

## Overview
Kotlin lambdas are function literals that can be stored, passed, and returned like other values. The official Kotlin docs explain that functions in Kotlin are first-class, which makes higher-order programming natural.

## Lambda basics
A lambda expression is an anonymous function written inside braces:

```kotlin
val sum: (Int, Int) -> Int = { a, b -> a + b }
```

Here:

- `(Int, Int) -> Int` is the function type
- `a` and `b` are parameters
- `a + b` is the return value

The last expression in the lambda becomes the result.

## Common uses
Lambdas are heavily used with:

- collection operations such as `map`, `filter`, and `fold`
- event callbacks
- Compose event handlers like `onClick`
- higher-order APIs that accept behavior as a parameter

## Function types and higher-order functions
Kotlin's docs define a higher-order function as one that takes a function as a parameter or returns one. Lambdas are the most common way to supply those function values.

Example:

```kotlin
val numbers = listOf(1, 2, 3)
val doubled = numbers.map { it * 2 }
```

## Best practices
- Keep lambdas short and readable.
- Use them when behavior is being passed to another API.
- Prefer named functions when the logic becomes large or reused.
- Learn the implicit `it` parameter, but do not overuse it when explicit names improve clarity.

## Common mistakes
- Writing long lambdas that hide intent.
- Overusing implicit `it` in nested lambdas.
- Forgetting that the last expression is the return value.

## References
- Kotlin lambdas: https://kotlinlang.org/docs/lambdas.html
