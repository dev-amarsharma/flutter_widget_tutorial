## ElevatedButton

In Flutter, the ElevatedButton widget creates a Material Design raised button. It is commonly used for primary actions.

```dart
ElevatedButton(
  onPressed: () {},
  child: Text('Click Me'),
)
```

The main parameters of the Flutter ElevatedButton widget are:

- **onPressed**: Callback when the button is pressed (required).
- **child**: The widget below this button, usually a Text or Icon (required).
- **style**: Customizes the button's appearance.
- **onLongPress**: Callback for long press.

### Quick Tips:
- Use `style` to customize color, shape, and padding.
- Use for primary actions in your UI.


### Things to Avoid:
- Avoid using for secondary or less important actions—use TextButton or OutlinedButton instead.
- Don’t forget to provide an onPressed callback.

## Class Definition

```dart
class ElevatedButton extends StatelessWidget {
  const ElevatedButton({
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
