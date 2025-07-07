## BottomSheet

In Flutter, the BottomSheet widget displays a modal or persistent sheet from the bottom of the screen. It is commonly used for additional actions or menus.

```dart
showModalBottomSheet(
  context: context,
  builder: (_) => Container(
    height: 200,
    child: Center(child: Text('Bottom Sheet')),
  ),
);
```

The main parameters of the Flutter BottomSheet widget are:

- **builder**: The builder for the sheet content (required).
- **backgroundColor**: The background color of the sheet.
- **shape**: The shape of the sheet.
- **elevation**: The z-coordinate of the sheet.
- **enableDrag**: Whether the sheet can be dragged.

### Quick Tips:
- Use for menus, actions, or additional content.
- Use showModalBottomSheet for modal sheets.


### Things to Avoid:
- Avoid overusing for critical actions.
- Don’t forget to provide a way to dismiss the sheet.

## Class Definition

```dart
class BottomSheet extends StatefulWidget {
  const BottomSheet({
    Key? key,
    required this.builder,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.enableDrag = true,
    this.onClosing,
    this.constraints,
  }) : super(key: key);

  // ...
}
```
