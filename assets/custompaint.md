## CustomPaint

In Flutter, the CustomPaint widget provides a canvas on which to draw custom graphics. It is commonly used for custom shapes, charts, and visualizations.

```dart
CustomPaint(
  painter: MyPainter(),
)
```

The main parameters of the CustomPaint widget are:

- **painter**: The custom painter for the foreground.
- **foregroundPainter**: The custom painter for the foreground.
- **child**: The widget below this paint.
- **size**: The size of the canvas.

### Quick Tips:
- Use for custom drawing and graphics.
- Combine with GestureDetector for interactive graphics.


### Things to Avoid:
- Avoid using for simple shapes—use built-in widgets instead.
- Don’t forget to dispose of resources in your painter.

## Class Definition

```dart
class CustomPaint extends SingleChildRenderObjectWidget {
  const CustomPaint({
    Key? key,
    this.painter,
    this.foregroundPainter,
    this.size = Size.zero,
    this.isComplex = false,
    this.willChange = false,
    Widget? child,
  }) : super(key: key, child: child);

  // ...
}
```
