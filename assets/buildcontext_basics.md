# BuildContext Basics

Represents the location of a widget in the widget tree.

---

## Description

`BuildContext` gives a widget access to information about where it sits in the tree. It is commonly used to:

- find inherited data such as theme or media query values
- navigate to another screen
- show snack bars or dialogs
- locate ancestors in the tree

Every widget's `build` method receives a `BuildContext`.

---

## Example

```dart
Widget build(BuildContext context) {
  final theme = Theme.of(context);

  return Scaffold(
    appBar: AppBar(title: const Text('Context Example')),
    body: Center(
      child: Text(
        'Primary color',
        style: TextStyle(color: theme.colorScheme.primary),
      ),
    ),
  );
}
```

---

## Key Points

- `BuildContext` is tied to a widget's position in the tree.
- A context can only access ancestors above it.
- Not every context can be used for navigation or snack bars in the same place.

---

## Quick Tips

- Use the `context` passed into `build` when possible.
- Use `Builder` when you need a new context under a widget like `Scaffold`.
- Be careful using context after async gaps if the widget may be unmounted.

---

## Things to Avoid

- Do not assume every context can find the same ancestors.
- Avoid using a stale context after the widget is disposed.
- Do not confuse `BuildContext` with app-wide state storage.

---

## See Also

- [`Navigator Push and Pop`](assets/navigator.md)
- [`Theme`](assets/theme.md)
- [`LayoutBuilder`](assets/layoutbuilder.md)
