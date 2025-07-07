
# Text Field

The `TextField` widget in Flutter is used to get text input from the user. It is commonly used in forms and search bars.

## Class Definition

```dart
TextField({
  Key? key,
  TextEditingController? controller,
  FocusNode? focusNode,
  InputDecoration? decoration = const InputDecoration(),
  TextInputType? keyboardType,
  TextInputAction? textInputAction,
  TextCapitalization textCapitalization = TextCapitalization.none,
  TextStyle? style,
  StrutStyle? strutStyle,
  TextDirection? textDirection,
  TextAlign textAlign = TextAlign.start,
  bool autofocus = false,
  bool obscureText = false,
  int? maxLines = 1,
  int? minLines,
  bool? enabled,
  ValueChanged<String>? onChanged,
  ... // more parameters for advanced usage
})
```

```dart
TextField(
  decoration: InputDecoration(labelText: 'Enter text'),
)
```

The main parameters of the Flutter TextField widget are:

- **controller**: Controls the text being edited.
- **decoration**: Controls the visual appearance (label, hint, icon, etc).
- **keyboardType**: The type of keyboard to use for editing the text.
- **obscureText**: Whether to hide the text (for passwords).
- **onChanged**: Called when the user changes the text.
- **maxLines**: The maximum number of lines.
- **enabled**: Whether the field is enabled.

### Quick Tips:
- Use a `TextEditingController` to read or modify the text.
- Use `InputDecoration` for labels, hints, and icons.

### Things to Avoid:
- Avoid using TextField for read-only text—use `Text` instead.
- Don’t forget to dispose of the controller if you create one.
