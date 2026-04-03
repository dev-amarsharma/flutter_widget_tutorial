# Higher-Order Functions

## Overview
A higher-order function is a function that takes another function as a parameter or returns a function. Kotlin’s official lambdas documentation defines it exactly this way.

These functions are central to Kotlin’s functional style and are used heavily in:

- collection operations
- UI callbacks
- builders and DSLs

## Example
```kotlin
fun <T, R> Collection<T>.fold(
  initial: R,
  combine: (acc: R, nextElement: T) -> R
): R {
  var accumulator = initial
  for (element in this) {
    accumulator = combine(accumulator, element)
  }
  return accumulator
}
```

The `combine` parameter is a function, so `fold` is a higher-order function.

## Function types
Kotlin uses function types such as:

- `(Int) -> String`
- `() -> Unit`
- `(A, B) -> C`
- `A.(B) -> C` for function types with receiver

These make higher-order APIs strongly typed.

## Lambdas and callable references
Higher-order functions are often used with:

- lambda expressions
- anonymous functions
- callable references such as `Int::times`

## Best practices
- Use higher-order functions when behavior should be passed in as data.
- Prefer clear parameter names for function-type arguments.
- Keep lambda-heavy APIs readable.

## Common mistakes
- Overcomplicating simple logic with too many nested lambdas.
- Writing higher-order APIs that are difficult to read at the call site.
- Forgetting that function types are part of the public API design.

## References
- Higher-order functions and lambdas: https://kotlinlang.org/docs/lambdas.html
