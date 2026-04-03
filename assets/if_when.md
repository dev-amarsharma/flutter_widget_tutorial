# If and When

## Overview
Kotlin uses `if` and `when` for conditional logic. The official Kotlin docs emphasize that both can be used as expressions, which means they can return values instead of only controlling execution flow.

## `if` as an expression
Unlike Java's ternary operator, Kotlin uses `if` directly as an expression:

```kotlin
val max = if (a > b) a else b
```

If you use `if` as an expression, you must provide an `else` branch so the compiler knows what value to return.

## `when` as a replacement for long condition chains
`when` is Kotlin's flexible branching construct. It can:

- match exact values
- group values in one branch
- check ranges with `in`
- check types with `is`
- work with or without a subject

Example:

```kotlin
val result = when (score) {
  in 90..100 -> "A"
  in 80..89 -> "B"
  in 70..79 -> "C"
  else -> "Needs improvement"
}
```

## Exhaustiveness
When `when` is used as an expression, it must be exhaustive. That usually means:

- add an `else` branch, or
- cover every possible enum, sealed type, or boolean case

This makes `when` especially useful with enums and sealed classes because the compiler can help ensure all states are handled.

## Useful patterns
- Use `if` for small binary decisions.
- Use `when` for multiple branches or readable type/value matching.
- Prefer expression style when you are computing a value.
- Use `when` without a subject when the branches are boolean conditions.

## Common mistakes
- Forgetting `else` when `if` or `when` is used as an expression.
- Writing long nested `if` chains when `when` would be clearer.
- Assuming `when` always needs `else`; it does not when every possible case is already covered.

## References
- Kotlin conditions and loops: https://kotlinlang.org/docs/control-flow.html
