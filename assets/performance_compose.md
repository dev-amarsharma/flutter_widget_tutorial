# Performance in Compose

## Overview
Compose performance is about keeping UI rendering smooth, recomposition efficient, and state updates targeted. Good performance practices help screens scroll well, respond quickly, and avoid unnecessary work.

## Common performance themes
- Avoid unnecessary recomposition by scoping state carefully.
- Use stable and lightweight UI models when possible.
- Prefer lazy containers for large lists.

## State and recomposition
- Only composables that read changed state need recomposition.
- State hoisting and derived state can reduce extra work when used appropriately.
- Passing unstable objects can increase recomposition churn.

## List and image considerations
- Use `LazyColumn` or `LazyRow` for long lists.
- Provide stable keys where appropriate.
- Load images efficiently and avoid oversized resources.

## Measurement and mindset
- Profile before guessing at bottlenecks.
- Focus on real hotspots instead of premature micro-optimizations.
- Keep business logic out of frequently recomposing UI code.

## Common mistakes
- Doing heavy work directly inside composables.
- Recreating expensive objects on every recomposition.
- Ignoring performance of large lists and images.

## Example
```kotlin
val filtered by remember(items, query) {
  derivedStateOf { items.filter { it.matches(query) } }
}
```

## Practice

1. Inspect one screen for state that could be hoisted or narrowed.
2. Move one expensive calculation out of direct composition.
3. Add stable keys to one lazy list if needed.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Kotlin language docs: https://kotlinlang.org/docs/home.html
