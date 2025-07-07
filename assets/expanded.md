
# Expanded

The `Expanded` widget in Flutter expands a child of a Row, Column, or Flex so that the child fills the available space. It is commonly used to create flexible layouts.

## Class Definition

```dart
Expanded({
  Key? key,
  int flex = 1,
  required Widget child,
})
```

```dart
Row(
  children: [
    Expanded(child: Text('Left')),
    Expanded(child: Text('Right')),
  ],
)
```

The main parameters of the Flutter Expanded widget are:

- **child**: The widget to expand (required).
- **flex**: The flex factor to determine how much space this child should take relative to others.

### Quick Tips:
- Use Expanded to make widgets share available space equally.
- Combine with `Flexible` for more control over space distribution.

### Things to Avoid:
- Avoid using Expanded outside of Row, Column, or Flex.
- Don’t wrap all children in Expanded unless you want them to share space equally.
