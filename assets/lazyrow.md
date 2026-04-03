# LazyRow

## Overview
`LazyRow` is the horizontal counterpart to `LazyColumn`. Android's Compose docs explain that lazy layouts compose only visible items, and `LazyRow` specifically lays items out in a horizontally scrolling list.

## Basic structure

```kotlin
LazyRow {
  items(categories) { category ->
    CategoryChip(category)
  }
}
```

It uses the same `LazyListScope` DSL as `LazyColumn`, but the orientation is horizontal.

## Common use cases
- horizontally scrolling chips
- media carousels
- product strips
- selectable filters

## Spacing and state
You can add spacing with `horizontalArrangement = Arrangement.spacedBy(...)` and control or inspect scroll position with `rememberLazyListState()`.

For dynamic data, stable keys help keep item state attached to the correct item when positions change.

## Best practices
- Use `LazyRow` for horizontal collections with many or unknown items.
- Keep item content compact and reusable.
- Provide stable keys when order changes.
- Avoid placing expensive work in every visible item.

## Common mistakes
- Using `Row` for a large horizontal collection.
- Forgetting that a horizontally scrolling list still needs good accessibility and touch sizing.
- Treating `LazyRow` as a replacement for every horizontally arranged layout, even when no scrolling is needed.

## References
- Lists and grids in Compose: https://developer.android.com/develop/ui/compose/lists
