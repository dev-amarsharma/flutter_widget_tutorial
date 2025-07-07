## TextButton

In Flutter, the TextButton widget creates a Material Design flat button. It is commonly used for less prominent actions.

```dart
TextButton(
  onPressed: () {},
  child: Text('Text Button'),
)
```

The main parameters of the Flutter TextButton widget are:

- **onPressed**: Callback when the button is pressed (required).
- **child**: The widget below this button, usually a Text or Icon (required).
- **style**: Customizes the button's appearance.
- **onLongPress**: Callback for long press.

### Quick Tips:
- Use for secondary or less important actions.
- Use `style` to customize appearance.

### Things to Avoid:
- Avoid using for primary actions—use ElevatedButton instead.
- Don’t forget to provide an onPressed callback.

## Class Definition

```dart
class TextButton extends StatelessWidget {
  const TextButton({
    Key? key,
    required this.onPressed,
    this.onLongPress,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    required this.child,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final Widget child;

  @override
  Widget build(BuildContext context) { /* ... */ }
}
```
