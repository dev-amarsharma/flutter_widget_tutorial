
# Flexible

The `Flexible` widget in Flutter controls how a child of a Row, Column, or Flex flexes. It allows a child to occupy available space with more control than Expanded.

## Class Definition

```dart
Flexible({
  Key? key,
  int flex = 1,
  FlexFit fit = FlexFit.loose,
  required Widget child,
})
```

```dart
Row(
  children: [
    Flexible(
      flex: 2,
      child: Container(color: Colors.red),
    ),
    Flexible(
      flex: 1,
      child: Container(color: Colors.blue),
    ),
  ],
)
```

The main parameters of the Flutter Flexible widget are:

- **child**: The widget to make flexible (required).
- **flex**: The flex factor to determine how much space this child should take relative to others.
- **fit**: How the child should fit within the available space (tight or loose).

### Quick Tips:
- Use Flexible for widgets that should take up available space but not necessarily all of it.
- Combine with `Expanded` for complex layouts.

### Things to Avoid:
- Avoid using Flexible outside of Row, Column, or Flex.
- Don’t use Flexible when a fixed size is needed.
