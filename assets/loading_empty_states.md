# Loading and Empty States

Makes asynchronous UI feel clear and intentional while data is loading or missing.

---

## Description

When data comes from APIs, storage, or other async sources, the UI should communicate what is happening.

Common states:

- loading: the app is waiting for data
- success: data is available
- empty: the request worked, but there is nothing to show
- error: something failed

Handling these states well improves user trust and avoids confusing blank screens.

---

## Example

```dart
Widget build(BuildContext context) {
  return FutureBuilder<List<String>>(
    future: loadItems(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return const Center(child: Text('Something went wrong'));
      }

      final items = snapshot.data ?? [];
      if (items.isEmpty) {
        return const Center(child: Text('No items yet'));
      }

      return ListView(
        children: items.map((item) => ListTile(title: Text(item))).toList(),
      );
    },
  );
}
```

---

## Key Points

- Loading states show that work is happening.
- Empty states are not the same as errors.
- Error states should explain what happened and, when possible, suggest what to do next.
- Async UI should avoid flashing between unrelated states unnecessarily.

---

## Quick Tips

- Keep empty state copy short and specific.
- Use retry actions for recoverable failures.
- Make loading indicators match the amount of time and scope of the task.

---

## Things to Avoid

- Do not show a blank screen while waiting for data.
- Avoid treating empty data as an error.
- Do not show technical exception details as the only user message.

---

## See Also

- [`FutureBuilder`](assets/futurebuilder.md)
- [`StreamBuilder`](assets/streambuilder.md)
- [`API Error Handling`](assets/api_error_handling.md)
