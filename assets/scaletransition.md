## ScaleTransition

In Flutter, the ScaleTransition widget animates the scale of a child using an Animation. It is commonly used for zoom-in and zoom-out effects.

```dart
ScaleTransition(
  scale: _animation,
  child: Icon(Icons.zoom_in),
)
```

The main parameters of the Flutter ScaleTransition widget are:

- **scale**: The animation controlling the scale (required).
- **child**: The widget to animate.

### Quick Tips:
- Use with AnimationController for custom scale effects.
- Combine with other transitions for complex animations.


### Things to Avoid:
- Avoid using for static widgets.
- Don’t forget to dispose of the AnimationController.

## Class Definition

```dart
class ScaleTransition extends AnimatedWidget {
  const ScaleTransition({
    Key? key,
    required Animation<double> scale,
    this.alignment = Alignment.center,
    this.child,
  }) : super(key: key, listenable: scale);

  final AlignmentGeometry alignment;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final Animation<double> scale = listenable as Animation<double>;
    return Transform.scale(
      scale: scale.value,
      alignment: alignment,
      child: child,
    );
  }
}
```
