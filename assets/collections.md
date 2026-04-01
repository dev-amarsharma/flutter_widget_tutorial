# Lists, Sets, and Maps

Stores groups of related values in Dart using collection types.

---

## Description

Dart provides several core collection types. A `List` stores ordered values, a `Set` stores unique values, and a `Map` stores key-value pairs. These structures are used constantly when working with app state, JSON data, and UI rendering.

- **Common use cases:**
  - Rendering lists of items
  - Tracking unique tags or ids
  - Storing configuration values by key
  - Parsing JSON responses

---

## Example

```dart
final names = ['Ava', 'Noah', 'Luca'];
final uniqueIds = {1, 2, 3};
final user = {'name': 'Ava', 'age': 21};

print(names[0]);
print(uniqueIds.contains(2));
print(user['name']);
```

---

## Key Points

- `List` keeps insertion order and allows duplicates.
- `Set` keeps unique values only.
- `Map` stores data as key-value pairs.
- Choose the collection type based on the shape of your data.

---

## Quick Tips

- Use `List` when you need ordered UI data.
- Use `Set` when duplicates should not exist.
- Use `Map<String, dynamic>` carefully when decoding JSON.

---

## Things to Avoid

- Avoid using a `List` when uniqueness matters.
- Avoid deeply nested maps when a class would be clearer.
- Do not assume every key exists in a map.

---

## See Also

- [`Variables and Data Types`](assets/dart_variables.md)
- [`JSON Parsing`](assets/json_parsing.md)
