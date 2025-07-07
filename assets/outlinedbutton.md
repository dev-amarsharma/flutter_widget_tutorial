
# Outlined Button

The `OutlinedButton` widget in Flutter creates a Material Design button with an outline border. It is commonly used for medium emphasis actions.

## Class Definition

```dart
OutlinedButton({
  Key? key,
  required VoidCallback? onPressed,
  VoidCallback? onLongPress,
  ButtonStyle? style,
  FocusNode? focusNode,
  bool autofocus = false,
  Clip clipBehavior = Clip.none,
  required Widget child,
})
```

```dart
OutlinedButton(
  onPressed: () {},
  child: Text('Outlined'),
)
```

The main parameters of the Flutter OutlinedButton widget are:

- **onPressed**: Callback when the button is pressed (required).
- **child**: The widget below this button, usually a Text or Icon (required).
- **style**: Customizes the button's appearance.
- **onLongPress**: Callback for long press.

### Quick Tips:
- Use for actions that need medium emphasis.
- Use `style` to customize border and color.

### Things to Avoid:
- Avoid using for primary actions—use ElevatedButton instead.
- Don’t forget to provide an onPressed callback.
