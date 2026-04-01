# Null Safety

Helps prevent null-related runtime errors by making nullability explicit.

---

## Description

In Dart, a variable cannot hold `null` unless its type allows it. This is called null safety.

For example:

- `String name = 'Ava';` cannot be `null`
- `String? name;` can be `null`

Null safety makes code more predictable and catches many mistakes at compile time.

---

## Example

```dart
String? nickname;

void main() {
  String name = 'Flutter';
  print(name.length);

  if (nickname != null) {
    print(nickname!.length);
  }
}
```

---

## Key Points

- Add `?` to a type when it may be null.
- Use null checks before accessing nullable values.
- Use `!` only when you are sure the value is not null.
- Use `??` to provide a fallback value.

---

## Quick Tips

- Prefer safe code with null checks over force unwrapping.
- Use `?.` for safe access when a value may be null.
- Use `??` to provide defaults for missing data.

---

## Things to Avoid

- Avoid using `!` unless you are certain the value is non-null.
- Do not treat nullable and non-nullable types as the same.
- Avoid skipping null checks with user input or API data.

---

## See Also

- [`Variables and Data Types`](assets/dart_variables.md)
- [`final vs const`](assets/final_vs_const.md)
