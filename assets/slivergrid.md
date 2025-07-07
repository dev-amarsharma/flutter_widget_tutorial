## SliverGrid

In Flutter, the SliverGrid widget displays a grid of children within a CustomScrollView. It is commonly used for advanced scrollable layouts.

```dart
SliverGrid(
  delegate: SliverChildBuilderDelegate(
    (context, index) => Container(color: Colors.blue, child: Text('Item $index')),
    childCount: 10,
  ),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
)
```

The main parameters of the SliverGrid widget are:

- **delegate**: Controls the children of the sliver (required).
- **gridDelegate**: Controls the layout of the grid (required).

### Quick Tips:
- Use inside CustomScrollView for advanced grids.
- Combine with other slivers for custom layouts.


### Things to Avoid:
- Avoid using outside of CustomScrollView.
- Don’t use for simple grids—use GridView instead.

## Class Definition

```dart
class SliverGrid extends SliverMultiBoxAdaptorWidget {
  const SliverGrid({
    Key? key,
    required SliverChildDelegate delegate,
    required SliverGridDelegate gridDelegate,
  }) : super(key: key, delegate: delegate);

  // ...
}
```
