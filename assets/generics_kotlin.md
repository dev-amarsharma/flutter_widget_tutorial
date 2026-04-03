# Generics in Kotlin

## Overview
Generics let you write classes, interfaces, and functions that work with different types while preserving type safety. The Kotlin docs present generics as a way to avoid duplicating logic for each type.

Example:

```kotlin
class Box<T>(val value: T)
```

Here, `T` is a type parameter.

## Why generics matter
Generics help:

- reuse code
- preserve compile-time type information
- reduce casts
- express APIs more clearly

## Generic functions
Kotlin also supports generic functions:

```kotlin
fun <T> singletonList(item: T): List<T> {
  return listOf(item)
}
```

## Variance basics
Kotlin docs introduce variance with:

- `out` for producer positions
- `in` for consumer positions

This helps model safe subtype relationships in generic APIs.

## Star projections
When the exact type argument is unknown, Kotlin supports star projections like `List<*>`.

## Best practices
- Use generics when behavior is the same across multiple types.
- Prefer meaningful type parameter names when more than one type is involved.
- Learn `in` and `out` for API design safety.

## Common mistakes
- Adding generics when a concrete type would be clearer.
- Misunderstanding variance and producing unsafe APIs.
- Overcomplicating simple code with unnecessary type parameters.

## References
- Kotlin generics: https://kotlinlang.org/docs/generics.html
