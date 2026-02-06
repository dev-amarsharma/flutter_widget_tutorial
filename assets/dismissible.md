# Dismissible

The `Dismissible` widget allows users to dismiss a widget by swiping it in a specified direction (usually horizontally). It is commonly used in lists to delete items (like archiving an email).

## Key Properties

- **key**: A required `Key` to uniquely identify the widget.
- **child**: The widget to be dismissed.
- **background**: A widget stacked behind the child, exposed when swiping.
- **secondaryBackground**: A widget exposed when swiping in the opposite direction.
- **onDismissed**: A callback called when the widget is successfully dismissed.
- **direction**: The direction in which the widget can be dismissed (e.g., `DismissDirection.endToStart`).

## Usage

```dart
Dismissible(
  key: Key(item.id),
  onDismissed: (direction) {
    // Remove the item from the data source
  },
  background: Container(color: Colors.red),
  child: ListTile(title: Text(item.title)),
)
```
