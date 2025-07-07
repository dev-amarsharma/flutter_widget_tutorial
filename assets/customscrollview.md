## CustomScrollView

In Flutter, the CustomScrollView widget allows you to create custom scroll effects with slivers. It is commonly used for advanced scrollable layouts.

```dart
CustomScrollView(
  slivers: [
    SliverList(
      delegate: SliverChildListDelegate([
        Text('Item 1'),
        Text('Item 2'),
      ]),
    ),
  ],
)
```

The main parameters of the CustomScrollView widget are:

- **slivers**: The list of sliver widgets (required).
- **scrollDirection**: The axis along which the scroll view scrolls.
- **controller**: Controls the scroll position.
- **reverse**: Whether the scroll view scrolls in the opposite direction.

### Quick Tips:
- Use for advanced scrollable layouts.
- Combine with SliverList and SliverGrid.


### Things to Avoid:
- Avoid using for simple lists—use ListView or GridView instead.
- Don’t forget to manage scroll controllers.

## Class Definition

```dart
class CustomScrollView extends ScrollView {
  const CustomScrollView({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    ScrollBehavior? scrollBehavior,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    required List<Widget> slivers,
    int? semanticChildCount,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  }) : super(
    key: key,
    scrollDirection: scrollDirection,
    reverse: reverse,
    controller: controller,
    primary: primary,
    physics: physics,
    scrollBehavior: scrollBehavior,
    dragStartBehavior: dragStartBehavior,
    restorationId: restorationId,
    clipBehavior: clipBehavior,
    keyboardDismissBehavior: keyboardDismissBehavior,
    semanticChildCount: semanticChildCount,
    children: slivers,
  );

  // ...
}
```
