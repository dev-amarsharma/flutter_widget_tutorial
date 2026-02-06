# CircularProgressIndicator

The `CircularProgressIndicator` is a material design circular progress indicator, which spins to indicate that the application is busy.

## Key Properties

- **value**: The value of this progress indicator, from 0.0 to 1.0. If null, the indicator spins indefinitely (indeterminate).
- **backgroundColor**: The color of the track.
- **color**: The color of the indicator itself.
- **strokeWidth**: The width of the line used to draw the circle.

## Usage

```dart
// Indeterminate (spinning)
const CircularProgressIndicator()

// Determinate (50% complete)
const CircularProgressIndicator(
  value: 0.5,
  color: Colors.blue,
  backgroundColor: Colors.grey,
)
```
