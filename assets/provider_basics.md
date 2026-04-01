# Provider Basics

Provides a simple way to share and update state across parts of the widget tree.

---

## Description

Provider is a popular state management package in Flutter. It is commonly used with `ChangeNotifier` to expose shared state to widgets below it in the tree.

Typical provider flow:

1. Create a model class such as a `ChangeNotifier`
2. Put it above part of the widget tree with `ChangeNotifierProvider`
3. Read or watch it from widgets using `context.watch`, `context.read`, or `Consumer`

---

## Example

```dart
class CounterModel extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }
}

ChangeNotifierProvider(
  create: (_) => CounterModel(),
  child: Builder(
    builder: (context) {
      final counter = context.watch<CounterModel>();
      return Text('Count: ${counter.count}');
    },
  ),
)
```

---

## Key Points

- Provider helps expose shared state to descendant widgets.
- `notifyListeners()` tells listening widgets to rebuild.
- `context.watch<T>()` rebuilds when the value changes.
- `context.read<T>()` gets the value without listening for rebuilds.

---

## Quick Tips

- Keep business logic in provider classes instead of UI widgets.
- Use `read` for actions and `watch` for reactive UI.
- Start simple before introducing larger state architectures.

---

## Things to Avoid

- Do not put large UI concerns inside the provider model.
- Avoid calling `watch` where you only need a one-time action.
- Do not forget `notifyListeners()` after changing observable state.

---

## See Also

- [`setState Basics`](assets/setstate_basics.md)
- [`ValueNotifier and ValueListenableBuilder`](assets/valuelistenablebuilder.md)
- [`BLoC Pattern`](assets/bloc_usage.md)
