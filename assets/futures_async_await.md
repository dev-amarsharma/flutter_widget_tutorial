# Futures and async/await

Handles work that finishes later, such as API calls, file reads, and delayed operations.

---

## Description

A `Future` represents a value that will be available at some point in the future. In Dart, `async` and `await` make asynchronous code easier to read by letting you write it in a style that looks similar to synchronous code.

- **Common use cases:**
  - Loading data from an API
  - Reading local storage
  - Waiting for a timer or delay
  - Running setup code before showing UI

---

## Example

```dart
Future<String> loadGreeting() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Hello, Flutter';
}

void main() async {
  final greeting = await loadGreeting();
  print(greeting);
}
```

---

## Key Points

- A `Future<T>` eventually completes with a value of type `T` or an error.
- Mark a function with `async` if it uses `await`.
- `await` pauses that async function until the future completes.
- Use `try` and `catch` to handle async errors cleanly.

---

## Quick Tips

- Return `Future<T>` from asynchronous functions.
- Use `await` instead of long chains of nested callbacks when readability matters.
- Keep UI responsive by moving long-running work off the immediate build flow.

---

## Things to Avoid

- Do not block the UI while waiting for slow operations.
- Avoid forgetting `await` when the next line depends on the result.
- Do not ignore errors from asynchronous work.

---

## See Also

- [`FutureBuilder`](assets/futurebuilder.md)
- [`Streams`](assets/streams.md)
- [`HTTP Requests`](assets/http_requests.md)
