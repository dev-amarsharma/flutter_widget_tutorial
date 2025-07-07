## GestureDetector

In Flutter, the GestureDetector widget detects gestures such as taps, drags, and swipes. It is commonly used for handling user interaction.

```dart
GestureDetector(
  onTap: () => print('Tapped'),
  child: Container(color: Colors.amber, width: 100, height: 100),
)
```

The main parameters of the GestureDetector widget are:

- **onTap**: Callback for tap gesture.
- **onDoubleTap**: Callback for double tap.
- **onLongPress**: Callback for long press.
- **onPanUpdate**: Callback for drag.
- **child**: The widget to detect gestures on.

### Quick Tips:
- Use for custom touch interactions.
- Combine with animations for interactive effects.


### Things to Avoid:
- Avoid using for simple buttons—use ElevatedButton or CupertinoButton instead.
- Don’t forget to handle all relevant gestures.

## Class Definition

```dart
class GestureDetector extends StatelessWidget {
  const GestureDetector({
    Key? key,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTap,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onDoubleTapDown,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressUp,
    this.onLongPressEnd,
    this.onVerticalDragDown,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onVerticalDragCancel,
    this.onHorizontalDragDown,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragCancel,
    this.onForcePressStart,
    this.onForcePressPeak,
    this.onForcePressUpdate,
    this.onForcePressEnd,
    this.onPanDown,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
    this.behavior,
    this.excludeFromSemantics = false,
    this.child,
    this.key,
  }) : super(key: key);

  // ...
}
```
