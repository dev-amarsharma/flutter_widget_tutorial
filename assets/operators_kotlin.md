# Operators in Kotlin

## Overview
Operators in Kotlin are symbols and language constructs used for arithmetic, comparison, assignment, logic, ranges, and more. They make expressions concise and readable when used clearly.

## Basic operator groups
- Arithmetic operators include `+`, `-`, `*`, `/`, and `%`.
- Comparison operators include `==`, `!=`, `>`, `<`, `>=`, and `<=`.
- Logical operators include `&&`, `||`, and `!`.

## Assignment and increment
- `=` assigns a value.
- Operators like `+=` and `-=` combine update with assignment.
- `++` and `--` change numeric values by one.

## Kotlin-specific notes
- `==` checks structural equality, while `===` checks reference equality.
- The `in` operator checks membership in ranges or collections.
- Operator overloading allows certain operators to map to functions in custom types.

## Why it matters
- Operators appear constantly in conditions, loops, state updates, and business rules.
- Understanding them improves readability and correctness.

## Common mistakes
- Confusing `==` with `===`.
- Writing expressions that are too dense to read.
- Using operator overloading in a confusing way.

## Example
```kotlin
val isAdult = age >= 18
val result = score ?: 0
if (name in allowedNames) {
  println(name)
}
```

## Practice

1. Rewrite one verbose condition using the right Kotlin operators.
2. Check whether you meant structural or reference equality in one comparison.
3. Use `in` with a range or collection in one small example.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Kotlin language docs: https://kotlinlang.org/docs/home.html
