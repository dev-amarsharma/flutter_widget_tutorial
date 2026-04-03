# Kotlin Extensions

## Overview
Kotlin extensions let you add new callable functionality to a class or interface without inheritance or modifying the original type. The Kotlin docs emphasize that extensions do not actually change the class; they only make new functions or properties callable with member-like syntax.

Common forms:

- extension functions
- extension properties

## Example
```kotlin
fun String.truncate(maxLength: Int): String {
  return if (length <= maxLength) this else take(maxLength - 3) + "..."
}
```

Usage:

```kotlin
println("JetpackCompose".truncate(8))
```

## Important rules
From Kotlin docs:

- extensions are resolved statically
- the receiver type is determined at compile time
- if a class already has a member with the same signature, the member wins
- extension properties cannot have backing fields

This means extensions are powerful syntax tools, but they do not override real members dynamically like virtual methods.

## Why they are useful
Extensions are especially good for:

- utility functions on existing types
- third-party APIs you cannot modify
- readable domain-specific helpers
- transformations and display helpers

## Best practices
- Check the standard library first before writing your own extension.
- Keep extensions focused and discoverable.
- Avoid naming that conflicts confusingly with existing members.
- Use extension properties only for computed values, not stored state.

## Common mistakes
- Assuming extensions actually modify the target class.
- Forgetting member functions take precedence over same-signature extensions.
- Trying to use backing fields in extension properties.

## References
- Kotlin extensions: https://kotlinlang.org/docs/extensions.html
