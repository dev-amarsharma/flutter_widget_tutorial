## AnimatedPositioned

In Flutter, the AnimatedPositioned widget automatically animates changes to its position within a Stack. It is commonly used for moving widgets smoothly in a Stack.

```dart
Stack(
  children: [
    AnimatedPositioned(
      left: isLeft ? 0 : 100,
      duration: Duration(milliseconds: 500),
      child: Icon(Icons.star),
    ),
  ],
)
```

The main parameters of the Flutter AnimatedPositioned widget are:

- **left, right, top, bottom**: The target positions.
- **duration**: The length of the animation (required).
- **curve**: The animation curve.
- **child**: The widget to animate.

### Quick Tips:
- Use inside a Stack for animated movement.
- Combine with state changes for effects.


### Things to Avoid:
- Avoid using outside of a Stack.
- Don’t forget to specify the duration.

## Class Definition

```dart
class AnimatedPositioned extends ImplicitlyAnimatedWidget {
  const AnimatedPositioned({
    Key? key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    required Duration duration,
    Curve curve = Curves.linear,
    Widget? child,
    VoidCallback? onEnd,
  }) : super(key: key, duration: duration, curve: curve, onEnd: onEnd);

  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;
  final Widget? child;

  @override
  AnimatedWidgetBaseState<AnimatedPositioned> createState() => _AnimatedPositionedState();
}
```
