# REST API Integration

Connects your Flutter app to structured backend endpoints for real app data.

---

## Description

REST API integration means sending HTTP requests to endpoints that expose resources such as users, posts, products, or orders. In Flutter, this usually combines:

1. HTTP requests
2. JSON parsing
3. Model mapping
4. Loading and error states
5. Repository or service classes

---

## Example

```dart
class PostRepository {
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('https://example.com/posts'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load posts');
    }

    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => Post.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
```

---

## Key Points

- Keep request logic in a repository or service layer.
- Convert API JSON into typed Dart models.
- Always handle loading, empty, and error states in the UI.
- Treat API responses as unreliable external data.

---

## Quick Tips

- Separate networking from widgets to keep UI code clean.
- Reuse model classes instead of passing raw maps around.
- Keep endpoint URLs and request logic organized in one place.

---

## Things to Avoid

- Do not put large API workflows directly inside the build method.
- Avoid tightly coupling UI widgets to raw HTTP response structures.
- Do not skip response validation or status checks.

---

## See Also

- [`HTTP Requests`](assets/http_requests.md)
- [`JSON Parsing`](assets/json_parsing.md)
- [`API Error Handling`](assets/api_error_handling.md)
