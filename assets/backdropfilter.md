# BackdropFilter

The `BackdropFilter` widget applies a filter (like a blur) to the existing painted content behind the widget. It is often used to create frosted glass effects.

## Key Properties

- **filter**: The image filter to apply (e.g., `ImageFilter.blur`).
- **child**: The widget that is rendered over the filtered background.

## Usage

```dart
Stack(
  children: <Widget>[
    Image.asset('assets/background.jpg'),
    Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    ),
  ],
)
```
