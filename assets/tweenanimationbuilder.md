## TweenAnimationBuilder

In Flutter, the TweenAnimationBuilder widget animates a value over time using a Tween. It is commonly used for custom animations.

```dart
TweenAnimationBuilder<double>(
  tween: Tween(begin: 0, end: 1),
  duration: Duration(seconds: 1),
  builder: (context, value, child) {
    return Opacity(
      opacity: value,
      child: child,
    );
  },
  child: Text('Tween'),
)
```

The main parameters of the Flutter TweenAnimationBuilder widget are:

- **tween**: The Tween to animate (required).
- **duration**: The length of the animation (required).
- **builder**: The function to build the animated widget (required).
- **curve**: The animation curve.
- **child**: The widget to animate.

### Quick Tips:
- Use for custom value animations.
- Combine with any widget for flexible effects.


### Things to Avoid:
- Avoid using for simple property animations—use AnimatedContainer instead.
- Don’t forget to specify the duration.

## Class Definition

```dart
class TweenAnimationBuilder<T> extends StatefulWidget {
  const TweenAnimationBuilder({
    Key? key,
    required this.tween,
    required this.builder,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.linear,
    this.onEnd,
    this.child,
  }) : super(key: key);

  final Tween<T> tween;
  final Duration duration;
  final Curve curve;
  final Widget? child;
  final VoidCallback? onEnd;
  final TransitionBuilder builder;

  @override
  State<TweenAnimationBuilder<T>> createState() => _TweenAnimationBuilderState<T>();
}
```
