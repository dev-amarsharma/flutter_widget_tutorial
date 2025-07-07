# Divider

The `Divider` widget in Flutter is a thin horizontal line, used to separate content in lists and layouts.

## Example

```dart
Divider(
  color: Colors.grey,
  thickness: 1,
  height: 16,
)
```

## Main Parameters
- **color**: The color of the line.
- **thickness**: The thickness of the line.
- **height**: The vertical space the divider occupies.
- **indent**: Empty space to the leading edge.
- **endIndent**: Empty space to the trailing edge.

## Quick Tips
- Use in ListView or Column to visually separate items.
- Adjust `indent` and `endIndent` for padding.

## Things to Avoid
- Avoid overusing dividers; use only when necessary for clarity.
- Don’t use for decorative purposes only.

## Class Definition

```dart
class Divider extends StatelessWidget {
  const Divider({
    Key? key,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  }) : super(key: key);

  // ...
}
```
