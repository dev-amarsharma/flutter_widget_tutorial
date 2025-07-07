
# Icon

The `Icon` widget in Flutter displays a graphical icon from the Material Icons font or other icon fonts. It is commonly used for buttons, navigation, and visual cues.

## Class Definition

```dart
Icon(
  IconData icon, {
  Key? key,
  double? size,
  Color? color,
  String? semanticLabel,
  TextDirection? textDirection,
})
```

```dart
Icon(
  Icons.favorite,
  color: Colors.red,
  size: 32,
)
```

The main parameters of the Flutter Icon widget are:

- **icon**: The icon to display (required).
- **color**: The color to use when drawing the icon.
- **size**: The size of the icon in logical pixels.
- **semanticLabel**: A label for accessibility.
- **textDirection**: The text direction to use for rendering the icon.

### Quick Tips:
- Use built-in Material icons via the `Icons` class.
- Combine Icon with `IconButton` for interactive icons.

### Things to Avoid:
- Avoid using Icon for images—use the Image widget for pictures.
- Don’t use too many icons in a small space; it can clutter the UI.
