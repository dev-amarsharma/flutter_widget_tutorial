# setState Basics

Updates local widget state and tells Flutter to rebuild the UI.

---

## Description

`setState()` is used inside the `State` class of a `StatefulWidget`. When you change local state, wrap that change in `setState()` so Flutter knows the widget needs to rebuild.

Use it for simple, local UI state such as:

- counters
- toggles
- selected tabs
- temporary form values

---

## Example

```dart
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Count: $count')),
      floatingActionButton: FloatingActionButton(
        onPressed: increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

---

## Key Points

- `setState()` should wrap the state update.
- Flutter rebuilds the widget after `setState()` runs.
- Use `setState()` for local UI state, not large app-wide state.

---

## Quick Tips

- Keep the code inside `setState()` small and focused on state changes.
- Do async work outside `setState()` when possible.
- Check `mounted` if you may update state after async work.

---

## Things to Avoid

- Do not call `setState()` when nothing changed.
- Avoid putting expensive logic inside `setState()`.
- Do not use `setState()` after the widget is disposed.

---

## See Also

- [`StatefulWidget`](assets/statefulwidget.md)
- [`ValueListenableBuilder`](assets/valuelistenablebuilder.md)
