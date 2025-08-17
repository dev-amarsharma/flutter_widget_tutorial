# Placeholder Widget

The `Placeholder` widget in Flutter is a simple widget that draws a box with a dashed border and an X, used to indicate that a widget will be added later. It is useful during development for visualizing layout structure.

## Constructor
```dart
Placeholder({
  Key? key,
  Color color = const Color(0xFF455A64),
  double strokeWidth = 2.0,
  double fallbackWidth = 400.0,
  double fallbackHeight = 400.0,
})
```

## Properties
- **color**: The color of the placeholder border and X. Default is blue-grey.
- **strokeWidth**: The width of the border lines. Default is 2.0.
- **fallbackWidth**: The width used if the widget is unbounded. Default is 400.0.
- **fallbackHeight**: The height used if the widget is unbounded. Default is 400.0.

## Example
```dart
Placeholder(
  color: Colors.red,
  strokeWidth: 4,
  fallbackHeight: 100,
  fallbackWidth: 100,
)
```

## Usage
Use `Placeholder` to mark areas in your layout where you plan to add widgets later. It is only for development and should not be used in production UIs.

---
[Flutter Docs: Placeholder](https://api.flutter.dev/flutter/widgets/Placeholder-class.html)
