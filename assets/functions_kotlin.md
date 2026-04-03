# Functions in Kotlin

## Overview
Functions are one of Kotlin’s core building blocks. The official Kotlin docs explain that a function declaration uses the `fun` keyword, parameters inside parentheses, and an optional return type when needed.

Example:

```kotlin
fun double(x: Int): Int {
  return x * 2
}
```

## Core syntax
Important points from the Kotlin docs:

- use `fun` to declare a function
- parameters use `name: Type` syntax
- parameter values are read-only inside the function body
- return type can be omitted when it is clear from an expression body

Example with an expression body:

```kotlin
fun square(x: Int) = x * x
```

## Return values
Functions may:

- return a value
- return `Unit` for no meaningful result

Example:

```kotlin
fun logMessage(message: String): Unit {
  println(message)
}
```

The explicit `: Unit` is often omitted.

## Parameters
Each parameter:

- must have an explicit type
- is separated by commas
- behaves like a read-only local value

You cannot reassign a parameter inside the function body.

## Best practices
- Prefer small focused functions.
- Use expression bodies when they improve readability.
- Choose function names that describe behavior clearly.
- Keep parameter lists intentional and understandable.

## Common mistakes
- Writing large functions that mix unrelated responsibilities.
- Naming functions too vaguely.
- Forgetting that parameters are read-only inside the function.

## References
- Kotlin functions: https://kotlinlang.org/docs/functions.html
