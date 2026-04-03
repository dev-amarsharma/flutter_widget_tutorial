# Custom Layout in Compose

## Overview
Compose lets you build custom layouts when the standard primitives are not enough. Android’s custom layout docs explain that layout in Compose follows three core steps:

1. measure children
2. decide the parent size
3. place children

Custom layout gives you explicit control over those steps.

## Why custom layout exists
Most UI can be built with `Row`, `Column`, `Box`, lazy lists, and modifiers. But custom layout becomes useful when:

- child placement follows non-standard rules
- size depends on a custom measurement strategy
- layout needs precise coordination not expressed by standard containers

## Important rule
Compose does not allow multi-pass measurement of the same child in a normal custom layout. Android’s docs emphasize that each child may not be measured more than once for different configurations in the same pass.

## Example
```kotlin
Layout(
  content = {
    Text("A")
    Text("B")
  }
) { measurables, constraints ->
  val placeables = measurables.map { it.measure(constraints) }
  val width = placeables.maxOf { it.width }
  val height = placeables.sumOf { it.height }

  layout(width, height) {
    var y = 0
    placeables.forEach { placeable ->
      placeable.placeRelative(0, y)
      y += placeable.height
    }
  }
}
```

## Best practices
- Prefer standard layouts first.
- Use custom layout only when the UI truly needs custom measurement or placement.
- Keep measurement logic predictable and readable.
- Understand constraints before writing layout code.

## Common mistakes
- Reaching for custom layout too early.
- Forgetting measurement rules and trying to measure children repeatedly.
- Mixing layout logic with unrelated UI state handling.

## References
- Custom layouts in Compose: https://developer.android.com/develop/ui/compose/layouts/custom
- Layouts in Compose: https://developer.android.com/develop/ui/compose/layouts
