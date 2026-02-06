# LinearProgressIndicator

The `LinearProgressIndicator` is a material design linear progress indicator, also known as a progress bar.

## Key Properties

- **value**: The progress value (0.0 to 1.0). Null for indeterminate.
- **backgroundColor**: Color of the track.
- **color**: Color of the progress line.
- **minHeight**: The minimum height of the line.

## Usage

```dart
// Indeterminate
const LinearProgressIndicator()

// Determinate (75%)
const LinearProgressIndicator(
  value: 0.75,
  color: Colors.green,
)
```
