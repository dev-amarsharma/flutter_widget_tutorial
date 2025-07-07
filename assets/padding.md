## Padding

In Flutter, the Padding widget adds empty space (padding) around its child. It is commonly used to create space inside layouts and between widgets.

```dart
Padding(
  padding: EdgeInsets.all(16),
  child: Text('Padded Text'),
)
```

The main parameters of the Flutter Padding widget are:

- **padding**: The amount of space to add around the child (required).
- **child**: The widget to apply padding to (required).

### Quick Tips:
- Use `EdgeInsets.symmetric` or `EdgeInsets.only` for custom padding.
- Combine Padding with other layout widgets for flexible designs.

### Things to Avoid:
- Avoid excessive nesting of Padding; combine paddings when possible.
- Don’t use Padding for alignment—use `Align` or `Center` for positioning.
