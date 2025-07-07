## Scrollbar

In Flutter, the Scrollbar widget adds a scroll thumb to a scrollable widget. It is commonly used to indicate scroll position.

```dart
Scrollbar(
  child: ListView(
    children: [Text('Item 1'), Text('Item 2')],
  ),
)
```

The main parameters of the Scrollbar widget are:

- **child**: The scrollable widget (required).
- **controller**: Controls the scroll position.
- **isAlwaysShown**: Whether the scrollbar is always visible.
- **thickness**: The thickness of the scrollbar.

### Quick Tips:
- Use for long lists and grids.
- Combine with ListView or GridView.


### Things to Avoid:
- Avoid using for short lists.
- Don’t forget to manage scroll controllers for custom behavior.

## Class Definition

```dart
class Scrollbar extends StatefulWidget {
  const Scrollbar({
    Key? key,
    required this.child,
    this.controller,
    this.isAlwaysShown,
    this.thickness,
    this.radius,
    this.thumbVisibility,
    this.trackVisibility,
    this.interactive = true,
    this.showTrackOnHover = false,
    this.hoverThickness,
    this.scrollbarOrientation,
    this.notificationPredicate = defaultScrollNotificationPredicate,
  }) : super(key: key);

  // ...
}
```
