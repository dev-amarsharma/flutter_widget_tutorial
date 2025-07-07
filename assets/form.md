## Form

In Flutter, the Form widget groups and manages multiple form fields, such as TextFormField. It provides validation and saving for the entire form.

```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Process data
          }
        },
        child: Text('Submit'),
      ),
    ],
  ),
)
```

The main parameters of the Flutter Form widget are:

- **child**: The widget below this form in the tree (usually a Column).
- **key**: The form's global key for validation and saving.
- **autovalidateMode**: Controls when to auto-validate.
- **onWillPop**: Called when the user attempts to dismiss the form.
- **onChanged**: Called when any form field changes.

### Quick Tips:
- Use a `GlobalKey<FormState>` to validate and save the form.
- Group related fields inside a Form for easier validation.

### Things to Avoid:
- Avoid using Form for a single field unless you need validation.

- Don’t forget to call `validate()` and `save()` on the form state.

## Class Definition

```dart
class Form extends StatefulWidget {
  const Form({
    Key? key,
    required this.child,
    this.onWillPop,
    this.onChanged,
    this.autovalidateMode,
    this.restorationId,
  }) : super(key: key);

  final Widget child;
  final WillPopCallback? onWillPop;
  final VoidCallback? onChanged;
  final AutovalidateMode? autovalidateMode;
  final String? restorationId;

  @override
  FormState createState() => FormState();
}
```
