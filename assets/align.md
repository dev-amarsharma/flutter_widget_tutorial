
# Align

The `Align` widget in Flutter aligns its child within itself according to the specified alignment. It is useful for precise positioning inside a parent widget.

## Class Definition

```dart
Align({
  Key? key,
  AlignmentGeometry alignment = Alignment.center,
  double? widthFactor,
  double? heightFactor,
  Widget? child,
})
```

```dart
Align(
  alignment: Alignment.bottomRight,
  child: Text('Bottom Right'),
)
```

The main parameters of the Flutter Align widget are:

- **alignment**: How to align the child within the parent (required).
- **widthFactor**: Scales the width of the Align based on the child's width.
- **heightFactor**: Scales the height of the Align based on the child's height.
- **child**: The widget to align (required).

### Quick Tips:
- Use `Alignment` constants like `Alignment.center`, `Alignment.topLeft`, etc.
- Combine Align with `Stack` for layered layouts.

### Things to Avoid:
- Avoid using Align when Center or Padding is sufficient.
- Don’t use Align for complex layouts—prefer `Row`, `Column`, or `Stack`.
