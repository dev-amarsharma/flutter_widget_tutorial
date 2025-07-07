
# Popup Menu Button

The `PopupMenuButton` widget in Flutter displays a menu when pressed. It is commonly used for additional actions and options.

## Class Definition

```dart
PopupMenuButton<T>({
  Key? key,
  required PopupMenuItemBuilder<T> itemBuilder,
  T? initialValue,
  PopupMenuItemSelected<T>? onSelected,
  PopupMenuCanceled? onCanceled,
  String? tooltip,
  Icon? icon,
  Offset offset = Offset.zero,
  bool enabled = true,
  ShapeBorder? shape,
  Color? color,
  double? elevation,
  ... // more parameters for advanced usage
})
```

```dart
PopupMenuButton<String>(
  onSelected: (value) {},
  itemBuilder: (context) => [
    PopupMenuItem(value: 'One', child: Text('One')),
    PopupMenuItem(value: 'Two', child: Text('Two')),
  ],
)
```

The main parameters of the Flutter PopupMenuButton widget are:

- **itemBuilder**: Builds the menu items (required).
- **onSelected**: Called when an item is selected.
- **icon**: The icon to display for the button.
- **offset**: The offset of the menu.
- **enabled**: Whether the button is enabled.

### Quick Tips:
- Use for overflow menus and extra actions.
- Use icons for compact menus.

### Things to Avoid:
- Avoid using for primary actions.
- Don’t put too many items in the menu.
