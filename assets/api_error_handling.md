# API Error Handling

Prepares your app to respond gracefully when network requests fail.

---

## Description

API requests can fail for many reasons:

- no internet connection
- timeout
- unauthorized request
- server error
- invalid response data

Good error handling keeps the app stable and gives the user clear feedback instead of crashing or silently failing.

---

## Example

```dart
Future<List<Post>> fetchPosts() async {
  try {
    final response = await http
        .get(Uri.parse('https://example.com/posts'))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map((item) => Post.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    throw Exception('Server returned ${response.statusCode}');
  } catch (e) {
    throw Exception('Unable to load posts: $e');
  }
}
```

---

## Key Points

- Wrap risky API calls in `try` and `catch`.
- Handle timeouts and bad status codes separately when useful.
- Show meaningful feedback to the user.
- Log errors clearly for debugging.

---

## Quick Tips

- Prefer user-friendly messages over raw stack traces in the UI.
- Distinguish between retryable failures and permanent failures.
- Provide retry actions where appropriate.

---

## Things to Avoid

- Do not ignore request failures.
- Avoid showing technical exception details directly to end users.
- Do not assume every non-200 response means the same thing.

---

## See Also

- [`HTTP Requests`](assets/http_requests.md)
- [`REST API Integration`](assets/rest_api_integration.md)
- [`Futures and async/await`](assets/futures_async_await.md)
