## NestedScrollView

In Flutter, the NestedScrollView widget allows you to create scrollable views that contain other scrollable views. It is commonly used for collapsible app bars and tab views.

```dart
NestedScrollView(
  headerSliverBuilder: (context, innerBoxIsScrolled) => [
    SliverAppBar(title: Text('Header')),
  ],
  body: ListView(children: [Text('Item 1'), Text('Item 2')]),
)
```

The main parameters of the NestedScrollView widget are:

- **headerSliverBuilder**: Builds the sliver headers (required).
- **body**: The main scrollable content (required).
- **controller**: Controls the scroll position.

### Quick Tips:
- Use for collapsible headers and tab views.
- Combine with SliverAppBar for advanced effects.


### Things to Avoid:
- Avoid using for simple lists—use ListView or GridView instead.
- Don’t forget to manage scroll controllers for custom behavior.

## Class Definition

```dart
class NestedScrollView extends StatefulWidget {
  const NestedScrollView({
    Key? key,
    required this.headerSliverBuilder,
    required this.body,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics,
    this.floatHeaderSlivers = false,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.dragStartBehavior = DragStartBehavior.start,
  }) : super(key: key);

  // ...
}
```
