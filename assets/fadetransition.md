## FadeTransition

In Flutter, the FadeTransition widget animates the opacity of a child using an Animation. It is commonly used for fade-in and fade-out effects.

```dart
FadeTransition(
  opacity: _animation,
  child: Text('Fade'),
)
```

The main parameters of the Flutter FadeTransition widget are:

- **opacity**: The animation controlling the opacity (required).
- **child**: The widget to animate.

### Quick Tips:
- Use with AnimationController for custom fade effects.
- Combine with other transitions for complex animations.


### Things to Avoid:
- Avoid using for static widgets.
- Don’t forget to dispose of the AnimationController.

## Class Definition

```dart
class FadeTransition extends AnimatedWidget {
  const FadeTransition({
    Key? key,
    required Animation<double> opacity,
    this.alwaysIncludeSemantics = false,
    this.child,
  }) : super(key: key, listenable: opacity);

  final bool alwaysIncludeSemantics;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final Animation<double> opacity = listenable as Animation<double>;
    return Opacity(
      opacity: opacity.value,
      alwaysIncludeSemantics: alwaysIncludeSemantics,
      child: child,
    );
  }
}
```
