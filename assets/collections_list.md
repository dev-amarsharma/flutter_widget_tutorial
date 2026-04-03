# Kotlin List

## Overview
Kotlin’s official collections docs define `List<T>` as an ordered collection with indexed access. Order matters, and elements can appear more than once.

Examples:

- a list of recent searches
- a list of chat messages
- a list of product results

## Core properties
According to Kotlin docs:

- list elements have positions starting at index `0`
- duplicate elements are allowed
- lists support indexed access such as `list[0]`

## Read-only vs mutable
Kotlin provides:

- `List<T>` for read-only access
- `MutableList<T>` for write operations such as add, remove, and update

Example:

```kotlin
val names: List<String> = listOf("Asha", "Ravi", "Asha")
val editable = mutableListOf("One", "Two")
editable.add("Three")
```

## Common operations
Useful list operations:

- `size`
- index access with `[]`
- `first()`, `last()`
- `indexOf()`
- transformations like `map`, `filter`, `sortedBy`

## Best practices
- Use `List` when callers should not modify the collection.
- Use `MutableList` only when mutation is truly needed.
- Prefer expressive standard library operations over manual index loops when clarity improves.

## Common mistakes
- Assuming lists prevent duplicates.
- Using mutable lists by default when read-only lists are enough.
- Forgetting that index positions start at zero.

## References
- Collections overview: https://kotlinlang.org/docs/collections-overview.html
- Collection operations overview: https://kotlinlang.org/docs/collection-operations.html
