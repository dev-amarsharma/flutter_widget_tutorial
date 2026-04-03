# Companion Object

## Overview
Kotlin companion objects let you define class-level functions and properties inside a class. The official Kotlin documentation explains that companion objects are useful for factory methods, shared utilities, and constants tied to the class.

Although they look similar to static members from Java, they are actually members of a singleton object associated with the class.

## Example
```kotlin
class User(val name: String) {
  companion object {
    fun create(name: String): User = User(name)
  }
}

val user = User.create("Asha")
```

## Key facts
From Kotlin docs:

- a companion object is declared inside a class
- the companion can be named or unnamed
- members can be accessed with the class name
- companion objects can implement interfaces

## Named vs unnamed
Example with a named companion:

```kotlin
class Parser {
  companion object Factory {
    fun create(): Parser = Parser()
  }
}
```

If unnamed, the default name is `Companion`.

## Best practices
- Use companion objects for factory methods and class-level utilities.
- Prefer top-level functions when the behavior is not meaningfully tied to the class.
- Avoid turning companion objects into general dumping grounds.

## Common mistakes
- Assuming companion object members are exactly the same as Java static semantics.
- Storing unrelated global behavior in a companion object.
- Using companions when a top-level declaration would be simpler.

## References
- Object declarations and expressions: https://kotlinlang.org/docs/object-declarations.html
