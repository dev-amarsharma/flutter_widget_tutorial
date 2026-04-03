# Data Classes

## Overview
Kotlin data classes are designed primarily to hold data. The Kotlin docs explain that the compiler automatically generates useful members such as:

- `equals()`
- `hashCode()`
- `toString()`
- `componentN()`
- `copy()`

This makes them a strong fit for models, UI state objects, and DTO-like structures.

## Example
```kotlin
data class User(
  val name: String,
  val age: Int
)
```

For this class, Kotlin generates equality, string output, destructuring support, and copy behavior automatically.

## Requirements
Kotlin’s rules include:

- the primary constructor must have at least one parameter
- primary constructor parameters must be marked `val` or `var`
- data classes cannot be abstract, open, sealed, or inner

## `copy()` behavior
The generated `copy()` function is useful for state updates:

```kotlin
val user = User("Asha", 20)
val updated = user.copy(age = 21)
```

Kotlin’s docs also note that `copy()` performs a shallow copy, so referenced mutable objects are still shared.

## Best practices
- Use data classes for value-like data holders.
- Prefer immutable properties where possible.
- Be careful with mutable objects inside data classes because equality and copy semantics may still share references.

## Common mistakes
- Assuming `copy()` performs a deep copy.
- Declaring important equality-relevant properties outside the primary constructor unintentionally.
- Using data classes for types whose main job is complex behavior rather than data representation.

## References
- Kotlin data classes: https://kotlinlang.org/docs/data-classes.html
- Kotlin classes: https://kotlinlang.org/docs/classes.html
