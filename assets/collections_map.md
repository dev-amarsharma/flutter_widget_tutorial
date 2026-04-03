# Kotlin Map

## Overview
Kotlin’s collections documentation defines a `Map<K, V>` as a collection of key-value pairs.

Important rules:

- keys are unique
- values can repeat
- maps are useful for storing logical associations

Examples:

- user ID to profile
- product code to price
- route name to screen title

## Core behavior
Kotlin maps are not inheritors of `Collection`, but they are still a core Kotlin collection type.

Common operations include:

- retrieving by key
- checking membership in keys or values
- reading `keys` and `values`

Example:

```kotlin
val scores = mapOf("Asha" to 10, "Ravi" to 8)
println(scores["Asha"])
```

## Mutable maps
For writes, Kotlin provides `MutableMap<K, V>`.

```kotlin
val editable = mutableMapOf("one" to 1)
editable["two"] = 2
editable["one"] = 11
```

## Best practices
- Use a map when lookup by unique key matters.
- Prefer read-only `Map` when callers should not mutate entries.
- Pick clear key types and stable lookup semantics.

## Common mistakes
- Assuming values must be unique.
- Using a map when ordered indexed access would be clearer.
- Confusing key existence with value existence.

## References
- Collections overview: https://kotlinlang.org/docs/collections-overview.html
