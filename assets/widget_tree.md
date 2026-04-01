# Widget Tree

Describes how Flutter builds UI by nesting widgets inside other widgets.

---

## Description

In Flutter, the UI is a tree of widgets. Parent widgets contain child widgets, and those children can contain more widgets. Understanding this structure helps you reason about layout, state flow, and how build methods compose screens.

- **Common use cases:**
  - Designing layouts
  - Debugging UI structure
  - Passing data down the tree
  - Understanding where `BuildContext` comes from

---

## Example

```dart
Scaffold(
  appBar: AppBar(title: const Text('Demo')),
  body: const Center(
    child: Text('Hello'),
  ),
)
```

---

## Key Points

- Every screen is built from nested widgets.
- Parent widgets pass configuration to child widgets.
- Rebuilding part of the tree updates the UI.
- `BuildContext` is tied to a widget's position in the tree.

---

## Quick Tips

- Break large build methods into smaller widgets.
- Use nesting intentionally for clarity.
- Learn to read the tree from root to leaf.

---

## Things to Avoid

- Avoid overly large widget trees in a single method.
- Avoid deeply nesting when extracted widgets would be clearer.
- Do not confuse the widget tree with the render tree.

---

## See Also

- [`StatelessWidget`](assets/textview.md)
- [`BuildContext Basics`](assets/buildcontext_basics.md)
