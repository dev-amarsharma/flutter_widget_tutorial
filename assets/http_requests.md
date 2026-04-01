# HTTP Requests

Lets your Flutter app talk to web servers and APIs.

---

## Description

HTTP requests are used to fetch data from a backend or send data to it. In Flutter, this is often done with packages like `http` or `dio`.

Typical request flow:

1. Send a request to a URL
2. Wait for the response
3. Check the status code
4. Parse the response body
5. Show success, loading, or error UI

---

## Example

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchPosts() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body) as List<dynamic>;
  }

  throw Exception('Failed to load posts');
}
```

---

## Key Points

- Use `await` to wait for the network response.
- Always check the response status code.
- Parse JSON only after confirming the response is valid.
- Show loading and error states in the UI.

---

## Quick Tips

- Put HTTP logic in a service or repository instead of directly in widgets.
- Handle timeouts and failed requests explicitly.
- Keep API URLs and parsing logic organized.

---

## Things to Avoid

- Do not assume every response is successful.
- Avoid putting large networking logic directly inside the build method.
- Do not ignore exceptions from failed requests.

---

## See Also

- [`Futures and async/await`](assets/futures_async_await.md)
- [`JSON Parsing`](assets/json_parsing.md)
- [`REST API Integration`](assets/rest_api_integration.md)
