# Exception Handling in Kotlin

## Overview
Kotlin treats all exceptions as unchecked by default. The official Kotlin docs explain that you can catch exceptions, but you do not need to declare them as checked exceptions in function signatures the way Java sometimes does.

Exception handling in Kotlin mainly involves:

- throwing exceptions
- catching exceptions
- cleanup with `finally`

## Throwing exceptions
Use `throw` to signal an error:

```kotlin
if (userInput < 0) {
  throw IllegalArgumentException("Input must be non-negative")
}
```

Kotlin also provides precondition helpers:

- `require()` for invalid arguments
- `check()` for invalid state
- `error()` for impossible or illegal states

## `try/catch/finally`
Typical handling:

```kotlin
val result = try {
  riskyOperation()
} catch (e: ArithmeticException) {
  -1
} finally {
  println("Finished")
}
```

Kotlin `try` can be used as an expression and return a value.

## Custom exceptions
You can define your own exception classes by extending `Exception` or another suitable exception type.

## Best practices
- Use precondition helpers for common validation checks.
- Catch exceptions where you can actually recover or translate them meaningfully.
- Keep exception messages useful.
- Prefer domain-specific handling instead of broad blanket catches when possible.

## Common mistakes
- Catching overly broad exceptions without a plan.
- Using exceptions for ordinary control flow.
- Throwing vague errors with no diagnostic message.

## References
- Kotlin exceptions: https://kotlinlang.org/docs/exceptions.html
- Kotlin exception specification: https://kotlinlang.org/spec/exceptions.html
