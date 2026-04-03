# val vs var

## Overview
`val` and `var` are Kotlin's two forms of variable and property declaration.

- `val` creates a read-only reference.
- `var` creates a mutable reference that can be reassigned.

This distinction appears everywhere in Kotlin, from local variables to constructor properties and Compose code.

## Core idea
The official Kotlin docs define:

- `val` for values that should not be reassigned
- `var` for values that may change

Example:

```kotlin
val id = 101
var progress = 0

progress = 1
```

`id` cannot be reassigned. `progress` can.

## Read-only reference vs mutable object
One common source of confusion is that `val` protects the reference, not necessarily the object.

```kotlin
val names = mutableListOf("Asha", "Ravi")
names.add("Mina") // valid
// names = mutableListOf("Zara") // invalid
```

The list can still change internally because `mutableListOf()` returns a mutable object.

## When to prefer `val`
Use `val` by default when:

- a result is computed once in the current scope
- a dependency should not change after construction
- a local variable is only used as a stable intermediate value

Examples:

```kotlin
val title = "Profile"
val userId = intent.getStringExtra("user_id")
val repository = UserRepository(api)
```

In Compose, many local computed values should be `val` because they are not reassigned inside the composable body.

## When `var` is appropriate
Use `var` when the value must change over time.

Examples:

```kotlin
var retryCount = 0
retryCount += 1
```

```kotlin
var selectedIndex = 0
```

In app code, `var` often appears in state holders, counters, mutable models, and properties that the app intentionally updates.

## Constructor properties
Kotlin also supports `val` and `var` directly in constructors:

```kotlin
class User(
  val id: String,
  var displayName: String
)
```

This creates:

- a read-only property `id`
- a mutable property `displayName`

That distinction matters when designing models and APIs.

## Best practices
- Start with `val` and switch to `var` only when reassignment is necessary.
- Keep mutable state scoped as narrowly as possible.
- Avoid unnecessary mutation in long functions.
- If you need true immutability, combine `val` with immutable data structures.

## Common mistakes
- Assuming `val` makes every object immutable.
- Using `var` by default out of habit.
- Reassigning the same variable multiple times when smaller steps would be clearer.
- Exposing mutable properties publicly when read-only access would be enough.

## Practice
1. Take a function with several `var` values and convert all unnecessary ones to `val`.
2. Inspect a model class and decide which constructor properties should be read-only.
3. Compare a `val` reference to a mutable list and a `val` reference to an immutable list.

## References
- Kotlin official docs: https://kotlinlang.org/docs/basic-syntax.html#variables
- Kotlin properties: https://kotlinlang.org/docs/properties.html
- Kotlin classes: https://kotlinlang.org/docs/classes.html
