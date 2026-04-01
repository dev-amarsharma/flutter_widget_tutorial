# Variables and Data Types

Stores values that your Dart code can read, update, and pass around.

---

## Description

Variables are named containers for data. Dart supports common data types such as `int`, `double`, `String`, `bool`, `List`, `Map`, and custom objects.

- **Common use cases:**
  - Storing user input
  - Keeping track of counters and flags
  - Passing values between methods
  - Holding data returned from APIs

---

## Example

```dart
void main() {
  String title = 'Flutter Tutorial';
  int lessonsCompleted = 12;
  double progress = 0.6;
  bool isPremiumUser = false;

  print(title);
  print(lessonsCompleted);
  print(progress);
  print(isPremiumUser);
}
```

---

## Key Points

- Use a clear variable name that explains the value.
- Choose the right type for the data you are storing.
- Dart can infer a type with `var`, but the value still has a fixed type after assignment.
- Strong typing helps catch mistakes at compile time.

---

## Quick Tips

- Prefer explicit types when they improve readability.
- Use `String`, `int`, `double`, and `bool` for simple values.
- Use `List` for ordered collections and `Map` for key-value data.

---

## Things to Avoid

- Avoid unclear names like `x`, `data1`, or `tempValue` when a better name exists.
- Do not assign the wrong type to a variable.
- Avoid using variables before they are initialized.

---

## See Also

- [`final vs const`](assets/final_vs_const.md)
- [`Null Safety`](assets/null_safety.md)
