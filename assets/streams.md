# Streams

Represents a sequence of asynchronous events over time.

---

## Description

A `Stream` is useful when data can update multiple times instead of just once. In Flutter, streams are common for:

- live backend updates
- search suggestions
- sensor data
- WebSocket messages
- repeated progress updates

Unlike a `Future`, which completes once, a `Stream` can emit many values.

---

## Example

```dart
Stream<int> countStream() async* {
  for (int i = 1; i <= 3; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
}

void main() async {
  await for (final value in countStream()) {
    print(value);
  }
}
```

---

## Key Points

- A stream can emit multiple values over time.
- `async*` and `yield` are commonly used to create streams.
- `await for` listens to stream events in sequence.
- `StreamBuilder` is commonly used to show stream data in Flutter UI.

---

## Quick Tips

- Use streams when your data changes repeatedly.
- Dispose or cancel stream subscriptions when they are no longer needed.
- Prefer `StreamBuilder` for simple UI-driven stream rendering.

---

## Things to Avoid

- Do not use a stream when a single future value is enough.
- Avoid forgetting to cancel long-lived stream subscriptions.
- Do not ignore stream errors.

---

## See Also

- [`FutureBuilder`](assets/futurebuilder.md)
- [`StreamBuilder`](assets/streambuilder.md)
- [`Futures and async/await`](assets/futures_async_await.md)
