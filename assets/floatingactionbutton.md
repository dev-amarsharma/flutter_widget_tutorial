## FloatingActionButton

In Flutter, the FloatingActionButton widget creates a circular button that floats above content. It is commonly used for primary actions in a screen.

```dart
FloatingActionButton(
  onPressed: () {},
  child: Icon(Icons.add),
)
```

The main parameters of the Flutter FloatingActionButton widget are:

- **onPressed**: Callback when the button is pressed (required).
- **child**: The widget below this button, usually an Icon (required).
- **backgroundColor**: The color of the button.
- **tooltip**: Text to show when the button is long-pressed.
- **heroTag**: Tag for hero animations.

### Quick Tips:
- Use for the main action on a screen.
- Use `tooltip` for accessibility.

### Things to Avoid:
- Avoid using multiple FABs on one screen.
- Don’t forget to provide an onPressed callback.
