# Card

The `Card` widget is a Material Design panel with slightly rounded corners and a shadow. It's commonly used to present related information in a concise container.

## Constructor
```dart
Card({
  Key? key,
  Color? color,
  double? elevation,
  ShapeBorder? shape,
  EdgeInsetsGeometry? margin,
  Clip clipBehavior = Clip.none,
  Widget? child,
  bool semanticContainer = true,
})
```

## Common properties
- `color` — background color of the card.
- `elevation` — z-coordinate shadow depth; higher value gives bigger shadow.
- `shape` — shape of the card's outline (use `RoundedRectangleBorder` to round corners).
- `margin` — outer spacing around the card.
- `clipBehavior` — how to clip the card's contents.
- `child` — typically a `Column`, `ListTile`, or other content widget.

## Example
```dart
Card(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Card title', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Supporting text that describes the card.'),
      ],
    ),
  ),
)
```

## Tips
- Use `ListTile` inside a `Card` for standard row layouts (leading icon, title, subtitle, trailing action).
- Combine with `InkWell` or `GestureDetector` to make the card tappable; prefer `InkWell` inside a `Material` for ripple effects.
- Adjust `elevation` and `shape` for different visual emphasis.

---
[Flutter Docs: Card](https://api.flutter.dev/flutter/material/Card-class.html)
