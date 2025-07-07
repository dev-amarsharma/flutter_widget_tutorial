## Radio

In Flutter, the Radio widget lets the user select a single option from a set. It is commonly used in forms and settings.

```dart
Radio(
  value: 1,
  groupValue: selectedValue,
  onChanged: (val) {},
)
```

The main parameters of the Flutter Radio widget are:

- **value**: The value represented by this radio button (required).
- **groupValue**: The currently selected value for the group (required).
- **onChanged**: Called when the user selects this radio button (required).
- **activeColor**: The color of the radio when selected.
- **materialTapTargetSize**: The size of the tap target.

### Quick Tips:
- Use the same `groupValue` for all radios in a group.
- Combine with `ListTile` for labeled radios.


### Things to Avoid:
- Avoid using Radio for multiple selections—use `Checkbox` instead.
- Don’t forget to update the groupValue when a radio is selected.

## Class Definition

```dart
class Radio<T> extends StatefulWidget {
  const Radio({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.activeColor,
    this.focusColor,
    this.hoverColor,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.mouseCursor,
    this.toggleable = false,
    this.fillColor,
    this.overlayColor,
    this.splashRadius,
  }) : super(key: key);

  // ...
}
```
