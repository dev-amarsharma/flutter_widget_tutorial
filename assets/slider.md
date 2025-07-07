## Slider

In Flutter, the Slider widget lets the user select a value from a range by sliding a thumb along a track. It is commonly used for settings like volume or brightness.

```dart
Slider(
  value: 50,
  min: 0,
  max: 100,
  onChanged: (val) {},
)
```

The main parameters of the Flutter Slider widget are:

- **value**: The current value of the slider (required).
- **min**: The minimum value (required).
- **max**: The maximum value (required).
- **onChanged**: Called when the user changes the value (required).
- **divisions**: Number of discrete divisions.
- **label**: Label to show above the slider.
- **activeColor**: The color of the active part of the slider.

### Quick Tips:
- Use `divisions` for discrete values.
- Use `label` to show the current value.


### Things to Avoid:
- Avoid using Slider for non-numeric values.
- Don’t forget to update the value in the onChanged callback.

## Class Definition

```dart
class Slider extends StatefulWidget {
  const Slider({
    Key? key,
    required this.value,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.semanticFormatterCallback,
  }) : super(key: key);

  // ...
}
```
