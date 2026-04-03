# Enum Classes in Kotlin

## Overview
Kotlin enum classes provide type-safe constants. The Kotlin docs describe their basic use case as implementing type-safe enums.

Example:

```kotlin
enum class Direction {
  NORTH, SOUTH, EAST, WEST
}
```

Each enum constant is an object instance of the enum class.

## What enums can contain
Enums can hold:

- constructor parameters
- properties
- functions
- per-entry behavior

Example:

```kotlin
enum class Color(val rgb: Int) {
  RED(0xFF0000),
  GREEN(0x00FF00),
  BLUE(0x0000FF)
}
```

## Useful enum APIs
Kotlin provides:

- `EnumClass.entries`
- `EnumClass.valueOf(name)`
- entry properties like `name` and `ordinal`

Example:

```kotlin
println(Direction.NORTH.name)     // NORTH
println(Direction.NORTH.ordinal)  // 0
```

`valueOf()` throws `IllegalArgumentException` if the name does not match any enum constant.

## Advanced behavior
The Kotlin docs also show that enum constants can:

- implement interfaces
- override abstract members with per-entry anonymous classes

This makes enums useful when each constant has a small variation in behavior.

## Best practices
- Use enums when the set of valid values is fixed and known.
- Prefer enums over raw strings for app states and modes when the domain is closed.
- Use properties on enum entries when extra metadata belongs with the constant.

## Common mistakes
- Using strings instead of enums for closed finite sets.
- Depending too heavily on `ordinal`, which can change if declaration order changes.
- Using enums for data that is not actually a fixed closed set.

## References
- Enum classes: https://kotlinlang.org/docs/enum-classes.html
