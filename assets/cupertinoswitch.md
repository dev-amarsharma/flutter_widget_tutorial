## CupertinoSwitch

In Flutter, the CupertinoSwitch widget creates an iOS-style switch. It is commonly used for toggling settings in Cupertino apps.

```dart
CupertinoSwitch(
  value: true,
  onChanged: (val) {},
)
```

The main parameters of the CupertinoSwitch widget are:

- **value**: Whether the switch is on or off (required).
- **onChanged**: Callback when the user toggles the switch (required).
- **activeColor**: The color of the switch when on.

### Quick Tips:
- Use for boolean settings in Cupertino apps.
- Combine with ListTile for labeled switches.


### Things to Avoid:
- Avoid using for Material apps—use Switch instead.
- Don’t forget to provide an onChanged callback.

## Class Definition

```dart
class CupertinoSwitch extends StatelessWidget {
  const CupertinoSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.trackColor,
    this.thumbColor,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final Color? trackColor;
  final Color? thumbColor;

  @override
  Widget build(BuildContext context) { /* ... */ }
}
```
