## TextFormField

In Flutter, the TextFormField widget is a form-aware version of TextField. It integrates with Form and provides validation and saving features.

```dart
TextFormField(
  decoration: InputDecoration(labelText: 'Enter your name'),
  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
)
```

The main parameters of the Flutter TextFormField widget are:

- **controller**: Controls the text being edited.
- **decoration**: Controls the visual appearance.
- **validator**: Function to validate user input.
- **onSaved**: Called when the form is saved.
- **initialValue**: The initial value of the field.
- **keyboardType**: The type of keyboard to use.
- **obscureText**: Whether to hide the text.

### Quick Tips:
- Use inside a `Form` widget for validation and saving.
- Use `validator` for custom validation logic.


### Things to Avoid:
- Avoid using TextFormField outside of a Form if you need validation.
- Don’t forget to call `FormState.save()` to trigger onSaved.

## Class Definition

```dart
class TextFormField extends FormField<String> {
  TextFormField({
    Key? key,
    this.controller,
    String? initialValue,
    FocusNode? focusNode,
    InputDecoration decoration = const InputDecoration(),
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    ToolbarOptions? toolbarOptions,
    bool? showCursor,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    ValueChanged<String>? onChanged,
    GestureTapCallback? onTap,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    TextSelectionControls? selectionControls,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    AutovalidateMode? autovalidateMode,
    ScrollController? scrollController,
    String? restorationId,
    bool enableIMEPersonalizedLearning = true,
  }) : super(
    key: key,
    initialValue: controller != null ? null : (initialValue ?? ''),
    onSaved: onSaved,
    validator: validator,
    enabled: enabled,
    autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
    builder: (FormFieldState<String> field) { /* ... */ },
    restorationId: restorationId,
  );

  final TextEditingController? controller;
  // ...
}
```
