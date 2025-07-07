
# Sized Box

The `SizedBox` widget in Flutter is used to create a box with a fixed width and/or height. It is commonly used for spacing or to constrain the size of a widget.

## Class Definition

```dart
SizedBox({
  Key? key,
  double? width,
  double? height,
  Widget? child,
})
```

```dart
SizedBox(
  width: 40,
  height: 40,
  child: Icon(Icons.star),
)
```

The main parameters of the Flutter SizedBox widget are:

- **width**: The width of the box.
- **height**: The height of the box.
- **child**: The widget to display inside the box (optional).

### Quick Tips:
- Use SizedBox for spacing between widgets (e.g., `SizedBox(height: 16)`).
- Use as a placeholder by omitting the child.

### Things to Avoid:
- Avoid using SizedBox for alignment—use `Align` or `Center` instead.
- Don’t use large numbers of SizedBox for layout; consider `Spacer` or flexible layouts.
