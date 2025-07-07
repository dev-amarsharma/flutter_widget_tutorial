## Scrollable

In Flutter, the Scrollable widget is a low-level widget that provides scrolling behavior for its child. It is commonly used for custom scrollable widgets.

```dart
Scrollable(
  axisDirection: AxisDirection.down,
  viewportBuilder: (context, offset) {
    return ListView(
      children: [Text('Item 1'), Text('Item 2')],
    );
  },
)
```

The main parameters of the Scrollable widget are:

- **axisDirection**: The direction in which the child scrolls (required).
- **viewportBuilder**: Builds the viewport (required).
- **controller**: Controls the scroll position.
- **physics**: The scroll physics.

### Quick Tips:
- Use for custom scrollable widgets.
- Combine with custom slivers for advanced layouts.


### Things to Avoid:
- Avoid using for standard lists—use ListView or GridView instead.
- Don’t forget to manage scroll controllers for custom behavior.

## Class Definition

```dart
class Scrollable extends StatefulWidget {
  const Scrollable({
    Key? key,
    required this.axisDirection,
    required this.viewportBuilder,
    this.controller,
    this.physics,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.restorationId,
    this.scrollBehavior,
    this.clipBehavior = Clip.hardEdge,
  }) : super(key: key);

  // ...
}
```
