## ValueListenableBuilder

In Flutter, the ValueListenableBuilder widget rebuilds when a ValueListenable changes. It is commonly used for simple state management.

```dart
ValueListenableBuilder<int>(
  valueListenable: counter,
  builder: (context, value, child) {
    return Text('Value: $value');
  },
)
```

The main parameters of the ValueListenableBuilder widget are:

- **valueListenable**: The ValueListenable to listen to (required).
- **builder**: The function to build the widget (required).
- **child**: The widget below this builder.

### Quick Tips:
- Use for simple reactive state updates.
- Combine with ValueNotifier for local state.

### Things to Avoid:
- Avoid for complex state—use a state management package.
- Don’t forget to dispose of ValueNotifier if needed.
