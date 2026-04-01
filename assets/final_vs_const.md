# final vs const

Controls whether a value is assigned once at runtime or fixed at compile time.

---

## Description

Both `final` and `const` are used for values that should not be reassigned, but they are not the same.

- `final` means the variable can be assigned once, at runtime.
- `const` means the value is a compile-time constant.

Use `const` when the value is fully known before the app runs. Use `final` when the value is computed later but still should not change after assignment.

---

## Example

```dart
final currentTime = DateTime.now();
const appName = 'Flutter Tutorial';

void main() {
  print(currentTime);
  print(appName);
}
```

---

## Key Points

- `final` is useful for values like API clients, timestamps, and objects created at runtime.
- `const` is useful for fixed literals such as labels, colors, and configurations known in advance.
- A `const` value is deeply immutable if its contents are also constant.

---

## Quick Tips

- Use `const` for widgets when possible to reduce unnecessary rebuild work.
- Use `final` for values that should not be reassigned after initialization.
- If a value depends on runtime data, `const` will not work.

---

## Things to Avoid

- Do not use `const` with values created at runtime such as `DateTime.now()`.
- Do not reassign a `final` variable.
- Avoid using `var` when `final` better describes your intent.

---

## See Also

- [`Variables and Data Types`](assets/dart_variables.md)
- [`Null Safety`](assets/null_safety.md)
