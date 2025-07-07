# Opacity

Displays its child with a given opacity.

---

## Description

The `Opacity` widget in Flutter makes its child partially transparent. You can use it to fade a widget in or out, or to make it less visually prominent. The opacity value ranges from 0.0 (completely transparent) to 1.0 (fully opaque).

- **Common use cases:**
  - Fading widgets in/out
  - Making UI elements less prominent
  - Animating opacity for effects

---

## Example

```dart
Opacity(
  opacity: 0.5, // 50% visible
  child: const Text('Half visible'),
)
```

---

## Class Definition

```dart
class Opacity extends SingleChildRenderObjectWidget {
  const Opacity({
    Key? key,
    required this.opacity,
    this.alwaysIncludeSemantics = false,
    Widget? child,
  }) : super(key: key, child: child);

  final double opacity;
  final bool alwaysIncludeSemantics;

  // ...
}
```

---

## Properties

| Name                     | Type     | Description                                 |
|--------------------------|----------|---------------------------------------------|
| `opacity`                | double   | The opacity value (0.0 to 1.0).             |
| `alwaysIncludeSemantics` | bool     | Whether to always include semantics.         |
| `child`                  | Widget?  | The widget below this widget in the tree.    |

---

## See Also

- [`AnimatedOpacity`](animatedopacity.md): Widget for animating opacity changes.
- [Official Opacity docs](https://api.flutter.dev/flutter/widgets/Opacity-class.html)
