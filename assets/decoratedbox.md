# DecoratedBox

The `DecoratedBox` widget in Flutter paints a decoration (such as a background or border) before its child.

## Example

```dart
DecoratedBox(
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
  ),
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Decorated'),
  ),
)
```

## Main Parameters
- **decoration**: The decoration to paint (required).
- **position**: Whether to paint before or after the child.
- **child**: The widget below this box.

## Quick Tips
- Use for backgrounds, borders, gradients, and shadows.
- Combine with Padding for spacing inside the decoration.

## Things to Avoid
- Avoid using for simple color backgrounds—use Container instead.
- Don’t use for interactive effects; use Ink or Material for ripples.

## Class Definition

```dart
class DecoratedBox extends SingleChildRenderObjectWidget {
  const DecoratedBox({
    Key? key,
    required this.decoration,
    this.position = DecorationPosition.background,
    Widget? child,
  }) : super(key: key, child: child);

  // ...
}
```
