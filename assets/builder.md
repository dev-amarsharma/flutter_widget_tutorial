## Builder

In Flutter, the Builder widget allows you to create a new BuildContext. It is commonly used when you need a different context than the parent.

```dart
Builder(
  builder: (context) {
    return Text('Inside Builder');
  },
)
```

The main parameters of the Builder widget are:

- **builder**: The function that returns the widget tree (required).

### Quick Tips:
- Use when you need a new BuildContext.
- Useful for showing dialogs or snackbars.

### Things to Avoid:

- Avoid using for every widget—only when a new context is needed.
- Don’t overuse for simple layouts.

## Class Definition

```dart
class Builder extends StatelessWidget {
  const Builder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => builder(context);
}
```
