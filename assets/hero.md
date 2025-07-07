## Hero

In Flutter, the Hero widget animates a widget from one screen to another during navigation. It is commonly used for shared element transitions.

```dart
Hero(
  tag: 'hero-tag',
  child: Image.asset('image.png'),
)
```

The main parameters of the Hero widget are:

- **tag**: The identifier for the hero (required).
- **child**: The widget to animate (required).
- **flightShuttleBuilder**: Customizes the transition animation.

### Quick Tips:
- Use the same tag on both source and destination widgets.
- Use for shared element transitions.


### Things to Avoid:
- Avoid using the same tag for multiple heroes on the same screen.
- Don’t forget to provide a unique tag.

## Class Definition

```dart
class Hero extends StatefulWidget {
  const Hero({
    Key? key,
    required this.tag,
    required this.child,
    this.createRectTween,
    this.flightShuttleBuilder,
    this.placeholderBuilder,
    this.transitionOnUserGestures = false,
  }) : super(key: key);

  final Object tag;
  final Widget child;
  final CreateRectTween? createRectTween;
  final HeroFlightShuttleBuilder? flightShuttleBuilder;
  final HeroPlaceholderBuilder? placeholderBuilder;
  final bool transitionOnUserGestures;

  @override
  State<Hero> createState() => _HeroState();
}
```
