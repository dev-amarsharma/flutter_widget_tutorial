## Switch

In Flutter, the Switch widget lets the user toggle between on and off states. It is commonly used for settings and preferences.

```dart
Switch(
  value: true,
  onChanged: (val) {},
)
```

The main parameters of the Flutter Switch widget are:

- **value**: Whether the switch is on or off (required).
- **onChanged**: Called when the user toggles the switch (required).
- **activeColor**: The color of the switch when on.
- **inactiveThumbColor**: The color of the thumb when off.
- **inactiveTrackColor**: The color of the track when off.

### Quick Tips:
- Use Switch for boolean settings.
- Combine with `ListTile` for labeled switches.


### Things to Avoid:
- Avoid using Switch for non-boolean values.
- Don’t forget to handle the onChanged callback.

## Class Definition

```dart
class Switch extends StatefulWidget {
  const Switch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.inactiveThumbImage,
    this.materialTapTargetSize,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.focusNode,
    this.autofocus = false,
    this.onActiveThumbImageError,
    this.onInactiveThumbImageError,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;
  final ImageProvider? activeThumbImage;
  final ImageProvider? inactiveThumbImage;
  final MaterialTapTargetSize? materialTapTargetSize;
  final DragStartBehavior dragStartBehavior;
  final MouseCursor? mouseCursor;
  final Color? focusColor;
  final Color? hoverColor;
  final FocusNode? focusNode;
  final bool autofocus;
  final ImageErrorListener? onActiveThumbImageError;
  final ImageErrorListener? onInactiveThumbImageError;

  @override
  State<Switch> createState() => _SwitchState();
}
```
