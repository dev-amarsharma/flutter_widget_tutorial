## AnimatedBuilder

In Flutter, the AnimatedBuilder widget rebuilds its child whenever the animation changes. It is commonly used for complex custom animations.

```dart
AnimatedBuilder(
  animation: _controller,
  builder: (context, child) {
    return Transform.rotate(
      angle: _controller.value * 2 * 3.14,
      child: child,
    );
  },
  child: Icon(Icons.refresh),
)
```

The main parameters of the Flutter AnimatedBuilder widget are:

- **animation**: The animation to listen to (required).
- **builder**: The function to build the animated widget (required).
- **child**: The widget to animate.

### Quick Tips:
- Use for complex, custom animations.
- Combine with AnimationController for full control.


### Things to Avoid:
- Avoid using for simple property animations.
- Don’t forget to dispose of the AnimationController.

## Class Definition

```dart
class AnimatedBuilder extends AnimatedWidget {
  const AnimatedBuilder({
    Key? key,
    required Listenable animation,
    required this.builder,
    this.child,
  }) : super(key: key, listenable: animation);

  final TransitionBuilder builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final Widget? child = this.child;
    return builder(context, child);
  }
}
```
