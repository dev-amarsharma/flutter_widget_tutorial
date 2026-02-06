# Chip

Chips are compact elements that represent an attribute, text, entity, or action. They are commonly used for filtering, choice selection, or displaying tags.

## Key Properties

- **label**: The primary content (usually text).
- **avatar**: An icon or image displayed before the label.
- **onDeleted**: Callback when the delete icon is pressed.
- **deleteIcon**: The icon to display for deletion.
- **backgroundColor**: The background color of the chip.

## Usage

```dart
Chip(
  avatar: CircleAvatar(child: Text('A')),
  label: Text('Aaron'),
  onDeleted: () {
    print('Deleted');
  },
)
```
