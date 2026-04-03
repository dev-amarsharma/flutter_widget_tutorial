# Default and Named Arguments

## Overview
Kotlin functions can define default parameter values and support named arguments when calling them. The official Kotlin functions documentation presents these features as a way to reduce overloads and improve call-site clarity.

## Default arguments
A parameter with a default value becomes optional:

```kotlin
fun greet(name: String = "Android") {
  println("Hello $name")
}
```

Calling `greet()` uses the default. Calling `greet("Asha")` overrides it.

## Named arguments
Named arguments make call sites clearer, especially when:

- a function has many parameters
- parameters are booleans
- several parameters have the same type

Example:

```kotlin
reformat(
  str = "Hello",
  normalizeCase = false,
  wordSeparator = '_'
)
```

Kotlin lets named arguments appear in any order.

## Important rules
From the Kotlin docs:

- after you skip a defaulted parameter, following arguments generally need names
- if a defaulted parameter appears before a non-defaulted one, you must name the later call-site argument when skipping the earlier one
- named arguments are not supported when calling Java functions on the JVM because parameter names are not always preserved in bytecode

## Best practices
- Use default arguments to avoid unnecessary overloads.
- Use named arguments when they significantly improve readability.
- Prefer named arguments for booleans or repeated primitive types.

## Common mistakes
- Overusing named arguments when the call is already obvious.
- Forgetting that Java methods do not generally support Kotlin named-argument syntax.
- Misunderstanding which later parameters must be named after skipping earlier defaults.

## References
- Kotlin functions: https://kotlinlang.org/docs/functions.html
- Kotlin coding conventions: https://kotlinlang.org/docs/coding-conventions.html
