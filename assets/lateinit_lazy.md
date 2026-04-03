# Lateinit and Lazy

## Overview
Kotlin gives you two different tools for deferred initialization: `lateinit` and `lazy`. They solve different problems. The Kotlin docs describe `lateinit` as a way to initialize a non-null `var` later, and `lazy` as a delegated property whose value is computed on first access and then cached.

## `lateinit`
Use `lateinit` when a mutable property cannot be assigned in the constructor but will be initialized before first use.

```kotlin
class UserRepositoryTest {
  lateinit var repository: UserRepository
}
```

Important rules from the docs:

- it works only with `var`
- the type must be non-nullable
- it cannot be a primitive type
- it cannot be declared in the primary constructor

If you read it too early, Kotlin throws `UninitializedPropertyAccessException`.

## `lazy`
Use `lazy` for read-only values that should be created only when first needed.

```kotlin
val config by lazy { loadConfig() }
```

The first access runs the lambda. Later accesses return the same stored value.

By default, Kotlin uses synchronized initialization. The docs also describe `LazyThreadSafetyMode.PUBLICATION` and `LazyThreadSafetyMode.NONE` for different threading needs.

## When to choose which
- Use `lateinit` for mutable lifecycle- or test-driven initialization.
- Use `lazy` for expensive read-only setup you want to defer until needed.

## Common mistakes
- Using `lateinit` for primitive or nullable types.
- Using `lateinit` when `lazy` would better express one-time initialization.
- Forgetting that `lazy` computes on first access, not at declaration time.

## References
- Kotlin properties: https://kotlinlang.org/docs/properties.html
- Kotlin delegated properties: https://kotlinlang.org/docs/delegated-properties.html
