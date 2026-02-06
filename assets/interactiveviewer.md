# InteractiveViewer

The `InteractiveViewer` widget enables pan, zoom, and scale interactions on its child. It is commonly used for viewing images, maps, or large diagrams on smaller screens.

## Key Properties

- **child**: The widget to be interacted with.
- **minScale**: The minimum allowed scale factor.
- **maxScale**: The maximum allowed scale factor.
- **panEnabled**: Whether panning is allowed (default: true).
- **scaleEnabled**: Whether scaling is allowed (default: true).
- **constrained**: Whether the child is constrained to the viewport (default: true).

## Usage

```dart
InteractiveViewer(
  panEnabled: true,
  boundaryMargin: const EdgeInsets.all(20),
  minScale: 0.5,
  maxScale: 4,
  child: Image.asset('assets/map.png'),
)
```
