# Transform

The `Transform` widget applies a transformation matrix to its child before painting it. This allows for rotation, scaling, translation (moving), and skewing.

## Key Properties

- **transform**: A `Matrix4` that defines the transformation.
- **alignment**: The origin of the transformation (default is center).
- **child**: The widget to be transformed.

## Usage

```dart
// Rotate by 45 degrees (pi/4 radians)
Transform.rotate(
  angle: 3.14 / 4,
  child: Container(color: Colors.blue, width: 100, height: 100),
)

// Scale by 1.5x
Transform.scale(
  scale: 1.5,
  child: Text('Zoomed'),
)
```
