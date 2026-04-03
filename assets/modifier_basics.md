# Modifier Basics

## Overview
Modifiers are one of the core building blocks of Compose UI. Android's official docs say modifiers decorate or augment a composable. They can change size, layout, behavior, appearance, accessibility information, and input handling.

## What modifiers can do
Common responsibilities include:

- sizing with `size`, `fillMaxWidth`, `requiredSize`
- spacing with `padding`
- positioning with `offset`
- interactions like `clickable`, `scrollable`, or draggable behavior
- semantics and accessibility metadata

Example:

```kotlin
Column(
  modifier = Modifier
    .padding(24.dp)
    .fillMaxWidth()
) { /* ... */ }
```

## Chaining and order
Modifiers are chained left to right, and order matters. Because each modifier builds on the previous one, changing the order can change layout, drawing, and touch behavior.

For example, padding before clickable can behave differently from clickable before padding.

## Reusability guidance
Android's docs recommend that composables generally accept a `modifier: Modifier = Modifier` parameter and pass it to the first UI-emitting child. This makes components more reusable and predictable.

The docs also note that extracting reusable modifier chains can improve readability and reduce repeated allocation during recomposition.

## Best practices
- Accept a `modifier` parameter in reusable composables.
- Keep modifier order intentional.
- Reuse modifier chains when it improves clarity or performance.
- Learn scoped modifiers such as `weight` and `matchParentSize`.

## Common mistakes
- Ignoring modifier order.
- Hard-coding layout behavior inside a composable without exposing `modifier`.
- Using scoped modifiers in the wrong parent context.

## References
- Compose modifiers: https://developer.android.com/develop/ui/compose/modifiers
- Modifiers list: https://developer.android.com/develop/ui/compose/modifiers-list
