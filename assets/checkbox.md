## Checkbox

In Flutter, the Checkbox widget lets the user select between two options: checked and unchecked. It is commonly used in forms and settings.

```dart
Checkbox(
  value: true,
  onChanged: (val) {},
)
```

The main parameters of the Flutter Checkbox widget are:

- **value**: Whether the checkbox is checked (required).
- **onChanged**: Called when the user toggles the checkbox (required).
- **activeColor**: The color of the checkbox when checked.
- **checkColor**: The color of the check icon.
- **tristate**: Whether the checkbox supports three states.

### Quick Tips:
- Use `tristate: true` for indeterminate state.
- Combine with `ListTile` for labeled checkboxes.

### Things to Avoid:

- Avoid using Checkbox for mutually exclusive options—use `Radio` instead.
- Don’t forget to handle the null state if using tristate.

## Class Definition

```dart
class Checkbox extends StatefulWidget {
  const Checkbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.checkColor,
    this.tristate = false,
    this.focusColor,
    this.hoverColor,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
    this.splashRadius,
    this.isError = false,
    this.mouseCursor,
    this.fillColor,
    this.overlayColor,
    this.stateLayerColor,
  }) : super(key: key);

  // ...
}
```
