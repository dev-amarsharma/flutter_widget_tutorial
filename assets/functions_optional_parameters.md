# Functions and Optional Parameters

Defines reusable blocks of code and allows flexible function calls with optional inputs.

---

## Description

Functions let you group logic into named units you can call from different places in your app. Dart also supports optional positional and named parameters, which helps you design APIs that are easier to read and easier to reuse.

- **Common use cases:**
  - Reusing business logic
  - Formatting text or numbers
  - Building helper methods for widgets
  - Passing configuration values only when needed

---

## Example

```dart
String greet(String name, {String prefix = 'Hello'}) {
  return '$prefix, $name';
}

void main() {
  print(greet('Ava'));
  print(greet('Liam', prefix: 'Welcome'));
}
```

---

## Key Points

- A function can return a value or `void`.
- Named parameters are wrapped in `{}`.
- Optional positional parameters are wrapped in `[]`.
- Default values make optional parameters safer to use.

---

## Quick Tips

- Use named parameters when a function has several configuration options.
- Give optional parameters clear default values when possible.
- Keep function names focused on what they do.

---

## Things to Avoid

- Avoid putting too many unrelated responsibilities in one function.
- Avoid optional parameters when a value should always be required.
- Do not use unclear parameter names that make calls hard to read.

---

## See Also

- [`Variables and Data Types`](assets/dart_variables.md)
- [`Classes and Objects`](assets/classes_objects.md)
