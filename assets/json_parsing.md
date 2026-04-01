# JSON Parsing

Converts JSON data from APIs into Dart values and models your app can use.

---

## Description

JSON is a common format for data sent by web APIs. In Flutter and Dart, you usually parse JSON with `jsonDecode` and then map the result into Dart objects.

Typical parsing flow:

1. Receive a JSON string from an API
2. Decode it into `Map` or `List`
3. Convert that structure into typed Dart models

---

## Example

```dart
import 'dart:convert';

class Post {
  final int id;
  final String title;

  Post({required this.id, required this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }
}

void main() {
  const rawJson = '{"id": 1, "title": "Learn Flutter"}';
  final decoded = jsonDecode(rawJson) as Map<String, dynamic>;
  final post = Post.fromJson(decoded);
  print(post.title);
}
```

---

## Key Points

- `jsonDecode` converts a JSON string into Dart `Map` or `List` objects.
- Factory constructors are commonly used to build models from JSON.
- Strongly typed models make app code safer and easier to maintain.

---

## Quick Tips

- Validate field names and expected types when parsing API responses.
- Use model classes instead of passing raw maps through the UI.
- Keep parsing logic close to the model or repository layer.

---

## Things to Avoid

- Do not assume every API field exists or has the right type.
- Avoid spreading raw JSON maps everywhere in your UI code.
- Do not skip error handling when decoding external data.

---

## See Also

- [`HTTP Requests`](assets/http_requests.md)
- [`REST API Integration`](assets/rest_api_integration.md)
- [`Collections`](assets/collections.md)
