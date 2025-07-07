## IconButton

In Flutter, the IconButton widget creates a button with an icon. It is commonly used for actions in toolbars, dialogs, and cards.

```dart
IconButton(
  icon: Icon(Icons.favorite),
  onPressed: () {},
)
```

The main parameters of the Flutter IconButton widget are:

- **icon**: The icon to display (required).
- **onPressed**: Callback when the button is pressed (required).
- **color**: The color of the icon.
- **iconSize**: The size of the icon.
- **tooltip**: Text to show when the button is long-pressed.

### Quick Tips:
- Use for compact actions in app bars and cards.
- Use `tooltip` for accessibility.

### Things to Avoid:
- Avoid using for text-only actions—use TextButton instead.
- Don’t forget to provide an onPressed callback.
