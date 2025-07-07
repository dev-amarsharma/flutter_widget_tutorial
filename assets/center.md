
# Center

The `Center` widget in Flutter centers its child both vertically and horizontally within its parent. It is commonly used to place a widget in the middle of the available space.

## Class Definition

```dart
Center({
  Key? key,
  double? widthFactor,
  double? heightFactor,
  Widget? child,
})
```

```dart
Center(
  child: Text('Centered Text'),
)
```

The main parameters of the Flutter Center widget are:

- **child**: The widget to center (required).
- **widthFactor**: Scales the width of the Center based on the child's width.
- **heightFactor**: Scales the height of the Center based on the child's height.

### Quick Tips:
- Use Center to quickly center any widget in its parent.
- Combine with `Column` or `Row` for more complex layouts.

### Things to Avoid:
- Avoid nesting multiple Centers; use only one per layout region.
- Don’t use Center if you need custom alignment—use `Align` for more control.
