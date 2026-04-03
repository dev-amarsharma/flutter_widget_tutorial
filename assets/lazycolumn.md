# LazyColumn

## Overview
`LazyColumn` is Compose's vertically scrolling lazy list. Android's official docs explain that lazy layouts compose and lay out only the items visible in the viewport, which makes them a better fit than a plain `Column` for large or unknown-length lists.

## Basic structure

```kotlin
LazyColumn {
  items(messages) { message ->
    MessageRow(message)
  }
}
```

Unlike `Column`, `LazyColumn` uses a DSL based on `LazyListScope`.

## Useful APIs
- `item { ... }` for a single item
- `items(list) { ... }` for a collection
- `itemsIndexed(...)` when you also need the index
- `rememberLazyListState()` to observe or control scroll position

## Performance-related guidance
The official docs recommend lazy lists when many items are involved because a normal `Column` would compose all items at once. `LazyColumn` only composes what is needed.

You can also provide stable item keys when list order can change so remembered item state is preserved better.

## Best practices
- Use `LazyColumn` for vertically scrolling data sets.
- Provide keys for dynamic lists with stable IDs.
- Hoist and reuse `LazyListState` when scroll position matters.
- Use spacing and content padding deliberately for readability.

## Common mistakes
- Using `Column` for large scrolling data sets.
- Forgetting keys when items move and local state matters.
- Putting too much work in each item composable.

## References
- Lists and grids in Compose: https://developer.android.com/develop/ui/compose/lists
