# ClipRRect

The `ClipRRect` (Rounded Rectangle Clip) widget clips its child using a rounded rectangle. It is commonly used to round the corners of images or containers that do not support `borderRadius` natively.

## Key Properties

- **borderRadius**: The radius of the rounded corners.
- **child**: The widget to be clipped.
- **clipBehavior**: Controls how to clip (default is `Clip.antiAlias`).

## Usage

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(15.0),
  child: Image.network('https://example.com/image.jpg'),
)
```
