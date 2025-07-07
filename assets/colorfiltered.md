# ColorFiltered

Applies a color filter to its child widget.

---

## Description

The `ColorFiltered` widget in Flutter allows you to apply a color filter to its child. This is useful for tinting images, changing their color, or applying blend modes for visual effects.

- **Common use cases:**
  - Tinting images
  - Applying grayscale or sepia effects
  - Custom color blending for UI elements

---

## Example

```dart
ColorFiltered(
  colorFilter: ColorFilter.mode(
    Colors.grey,
    BlendMode.saturation,
  ),
  child: Image.asset('assets/sample.png'),
)
```

---

## Class Definition

```dart
class ColorFiltered extends SingleChildRenderObjectWidget {
  const ColorFiltered({
    Key? key,
    required this.colorFilter,
    Widget? child,
  }) : super(key: key, child: child);

  final ColorFilter colorFilter;

  // ...
}
```

---

## Properties

| Name          | Type       | Description                                 |
|---------------|------------|---------------------------------------------|
| `colorFilter` | ColorFilter| The color filter to apply.                  |
| `child`       | Widget?    | The widget below this widget in the tree.   |

---

## See Also

- [Official ColorFiltered docs](https://api.flutter.dev/flutter/widgets/ColorFiltered-class.html)
