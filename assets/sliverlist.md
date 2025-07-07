## SliverList

In Flutter, the SliverList widget displays a linear list of children within a CustomScrollView. It is commonly used for advanced scrollable layouts.

```dart
SliverList(
  delegate: SliverChildListDelegate([
    Text('Item 1'),
    Text('Item 2'),
  ]),
)
```

The main parameters of the SliverList widget are:

- **delegate**: Controls the children of the sliver (required).

### Quick Tips:
- Use inside CustomScrollView for advanced lists.
- Combine with other slivers for custom layouts.


### Things to Avoid:
- Avoid using outside of CustomScrollView.
- Don’t use for simple lists—use ListView instead.

## Class Definition

```dart
class SliverList extends SliverMultiBoxAdaptorWidget {
  const SliverList({
    Key? key,
    required SliverChildDelegate delegate,
  }) : super(key: key, delegate: delegate);

  // ...
}
```
