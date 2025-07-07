## AnimatedContainer

In Flutter, the AnimatedContainer widget automatically animates changes to its properties, such as size, color, and alignment. It is commonly used for smooth transitions.

```dart
AnimatedContainer(
  duration: Duration(seconds: 1),
  color: isRed ? Colors.red : Colors.blue,
  width: 100,
  height: 100,
)
```

The main parameters of the Flutter AnimatedContainer widget are:

- **duration**: The length of the animation (required).
- **curve**: The animation curve.
- **width**: The width of the container.
- **height**: The height of the container.
- **color**: The background color.
- **alignment**: The alignment of the child.
- **child**: The widget below this container.

### Quick Tips:
- Use for simple property animations.
- Combine with GestureDetector for interactive effects.


### Things to Avoid:
- Avoid using for complex animations—use AnimationController for more control.
- Don’t forget to specify the duration.

## Class Definition

```dart
class AnimatedContainer extends ImplicitlyAnimatedWidget {
  const AnimatedContainer({
    Key? key,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.child,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
    Clip clipBehavior = Clip.none,
  }) : super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Widget? child;
  final Clip clipBehavior;

  @override
  AnimatedWidgetBaseState<AnimatedContainer> createState() => _AnimatedContainerState();
}
```
