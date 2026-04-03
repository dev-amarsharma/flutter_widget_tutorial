# Loops in Kotlin

## Overview
Kotlin supports `for`, `while`, and `do-while` loops. The official Kotlin docs explain that `for` iterates through collections, arrays, or ranges, while `while` and `do-while` repeat based on a boolean condition.

## `for` loops
`for` is the most common iteration form in idiomatic Kotlin.

```kotlin
for (item in shoppingList) {
  println(item)
}
```

You can iterate over:

- collections
- arrays
- ranges like `1..5`
- reverse ranges with `downTo`
- custom steps with `step`

For indexed iteration, Kotlin docs show using `indices` or `withIndex()`.

## `while` and `do-while`
- `while` checks the condition before each iteration
- `do-while` runs the body once before checking the condition

That means `do-while` always executes at least once.

## Control flow helpers
Kotlin supports `break` and `continue`. The returns-and-jumps docs also show labeled `break` and `continue` for nested loops.

## Best practices
- Prefer `for` for collections and ranges.
- Use `withIndex()` when you need both index and value.
- Use `while` only when the loop naturally depends on a changing condition.
- Keep loop bodies focused and readable.

## Common mistakes
- Choosing `while` when a `for` loop is clearer.
- Forgetting that `do-while` executes at least once.
- Writing overly complex nested loops instead of using clearer collection operations when appropriate.

## References
- Kotlin conditions and loops: https://kotlinlang.org/docs/control-flow.html
- Kotlin returns and jumps: https://kotlinlang.org/docs/returns.html
