# Classes and Objects

Defines custom data structures and behavior using object-oriented programming in Dart.

---

## Description

A class is a blueprint for creating objects. An object is an instance of that class with its own state and behavior. In Flutter and Dart, classes are used everywhere, from simple models to full widgets and services.

- **Common use cases:**
  - Modeling app data
  - Grouping state and methods together
  - Creating reusable business logic
  - Building custom widgets and controllers

---

## Example

```dart
class User {
  final String name;
  final int age;

  User(this.name, this.age);

  String describe() {
    return '$name is $age years old';
  }
}

void main() {
  final user = User('Mia', 24);
  print(user.describe());
}
```

---

## Key Points

- A class defines fields and methods.
- An object is created from a class.
- Constructors initialize new objects.
- `final` fields are useful for immutable model objects.

---

## Quick Tips

- Keep classes focused on one clear responsibility.
- Use meaningful names for fields and methods.
- Prefer small model classes over large unstructured maps.

---

## Things to Avoid

- Avoid mixing unrelated logic into one class.
- Avoid exposing mutable state unless it is necessary.
- Do not create classes when a simple function would solve the problem.

---

## See Also

- [`Functions and Optional Parameters`](assets/functions_optional_parameters.md)
- [`StatefulWidget`](assets/statefulwidget.md)
