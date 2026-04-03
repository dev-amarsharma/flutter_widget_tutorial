# Object Keyword

## Overview
The `object` keyword in Kotlin is used for singleton declarations, anonymous objects, and companion objects. It is a flexible feature that helps group behavior and state without creating regular class instances manually.

## Singleton objects
- A top-level `object` creates a single shared instance.
- It is useful for stateless helpers, managers, or constants grouped with behavior.

## Anonymous objects
- You can create an unnamed object expression for one-off implementations.
- This is useful for listeners, callbacks, or small temporary customizations.

## Companion objects
- A companion object attaches class-level members to a class.
- It is often used for factory methods, constants, or helper functions tied to that class.

## Android use cases
- Singleton utilities can hold stateless mapping or formatting logic.
- Companion objects are common for route builders, factory methods, and constants.

## Best practices
- Use `object` when shared single-instance semantics are intentional.
- Avoid turning every helper into a global singleton without need.

## Example
```kotlin
object AppRoutes {
  const val Home = "home"
  const val Profile = "profile"
}
```

## Practice

1. Create one singleton object for route or constant definitions.
2. Refactor one utility class that never needs instantiation into an object.
3. Use a companion object for one factory function in a data model.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Kotlin language docs: https://kotlinlang.org/docs/home.html
