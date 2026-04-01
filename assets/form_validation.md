# Form and Validation

Helps collect user input and check whether it is valid before submission.

---

## Description

Flutter forms are commonly built with `Form` and `TextFormField`. Validation lets you block invalid submissions and show helpful error messages.

Typical form flow:

1. Wrap fields in a `Form`
2. Give the form a `GlobalKey<FormState>`
3. Add `validator` functions to fields
4. Call `validate()` before saving or submitting

---

## Example

```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        decoration: const InputDecoration(labelText: 'Email'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email is required';
          }
          return null;
        },
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Submit form
          }
        },
        child: const Text('Submit'),
      ),
    ],
  ),
)
```

---

## Key Points

- `Form` groups related form fields together.
- `validator` returns `null` when the input is valid.
- `validator` returns an error string when the input is invalid.
- `validate()` runs every validator in the form.

---

## Quick Tips

- Write error messages that explain what the user should fix.
- Keep validation rules close to the field they belong to.
- Use `TextFormField` instead of `TextField` when form validation is needed.

---

## Things to Avoid

- Do not submit the form without checking `validate()`.
- Avoid vague error messages like `Invalid input` when you can be more specific.
- Do not put validation-heavy flows outside a `Form` when multiple fields are involved.

---

## See Also

- [`TextFormField`](assets/textformfield.md)
- [`TextField`](assets/textfield.md)
