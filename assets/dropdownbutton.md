## DropdownButton

In Flutter, the DropdownButton widget lets the user select one value from a list of items. It is commonly used in forms and settings.

```dart
DropdownButton<String>(
  value: 'One',
  items: [
    DropdownMenuItem(value: 'One', child: Text('One')),
    DropdownMenuItem(value: 'Two', child: Text('Two')),
  ],
  onChanged: (val) {},
)
```

The main parameters of the Flutter DropdownButton widget are:

- **items**: The list of items to display (required).
- **value**: The currently selected value.
- **onChanged**: Called when the user selects an item (required).
- **hint**: Widget to display when no value is selected.
- **icon**: The dropdown arrow icon.
- **isExpanded**: Whether to expand to fill the parent.

### Quick Tips:
- Use DropdownMenuItem for each item.
- Use `isExpanded` for full-width dropdowns.


### Things to Avoid:
- Avoid using DropdownButton for large lists—consider a searchable dialog.
- Don’t forget to handle the onChanged callback.

## Class Definition

```dart
class DropdownButton<T> extends StatefulWidget {
  const DropdownButton({
    Key? key,
    required this.items,
    this.value,
    this.hint,
    this.disabledHint,
    this.onChanged,
    this.elevation = 8,
    this.style,
    this.underline,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    this.isDense = false,
    this.isExpanded = false,
    this.itemHeight = kMinInteractiveDimension,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,
    this.dropdownColor,
    this.menuMaxHeight,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
    this.borderRadius,
  }) : super(key: key);

  // ...
}
```
