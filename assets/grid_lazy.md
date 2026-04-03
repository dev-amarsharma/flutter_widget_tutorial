# Lazy Grids in Compose

## Overview
Compose lazy grids display grid content efficiently in a scrollable container. Android’s lists and grids docs explain that:

- `LazyVerticalGrid` scrolls vertically and spans items across columns
- `LazyHorizontalGrid` scrolls horizontally and spans items across rows

Like lazy lists, grids render items on demand for better performance with larger datasets.

## Core APIs
Common APIs:

- `LazyVerticalGrid`
- `LazyHorizontalGrid`
- `GridCells.Adaptive`
- `GridCells.Fixed`

Example:

```kotlin
LazyVerticalGrid(
  columns = GridCells.Adaptive(minSize = 128.dp)
) {
  items(photos) { photo ->
    PhotoItem(photo)
  }
}
```

`GridCells.Adaptive` lets Compose choose how many columns fit given a minimum cell size.

## When to use lazy grids
Use a lazy grid when:

- content is naturally grid-like
- datasets can be large
- efficient scrolling matters
- the layout should adapt across widths

## Best practices
- Use lazy grids for larger or scrolling grid content.
- Choose `Adaptive` when responsive column count is helpful.
- Choose `Fixed` when the design needs a strict column count.
- Keep item composables lightweight and reusable.

## Common mistakes
- Using a non-lazy manual grid for large datasets.
- Ignoring adaptive sizing needs on different widths.
- Making each grid item too heavy to render efficiently.

## References
- Lists and grids in Compose: https://developer.android.com/develop/ui/compose/lists
- Create a scrollable grid: https://developer.android.com/develop/ui/compose/quick-guides/content/create-scrollable-grid
