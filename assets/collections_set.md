# Kotlin Set

## Overview
Kotlin defines `Set<T>` as a collection of unique elements. Unlike a list, a set does not allow duplicates as part of its logical model.

This makes sets useful for:

- tags
- unique IDs
- membership checks

## Core properties
From Kotlin docs:

- elements are unique
- order usually has no semantic meaning
- some implementations preserve insertion order, others do not

Example:

```kotlin
val ids = setOf(1, 2, 3, 3)
println(ids) // duplicates collapse logically
```

## Mutable sets
Kotlin also provides `MutableSet<T>` when you need to add or remove items.

Default mutable behavior typically preserves insertion order through `LinkedHashSet`, while `HashSet` does not guarantee predictable iteration order.

## Best practices
- Use a set when uniqueness matters more than position.
- Do not rely on iteration order unless the implementation guarantees it.
- Prefer read-only `Set` when mutation is not required.

## Common mistakes
- Expecting duplicates to be preserved.
- Using a set when a list would better model ordered data.
- Depending on element order without knowing the actual implementation.

## References
- Collections overview: https://kotlinlang.org/docs/collections-overview.html
- Retrieve single elements: https://kotlinlang.org/docs/collection-elements.html
