## GridView

In Flutter, the GridView widget displays a scrollable grid of widgets. It is commonly used for image galleries and grids of items.

```dart
GridView.count(
  crossAxisCount: 2,
  children: [
    Card(child: Text('Item 1')),
    Card(child: Text('Item 2')),
  ],
)
```

The main parameters of the GridView widget are:

- **children**: The list of widgets to display.
- **crossAxisCount**: The number of columns.
- **mainAxisSpacing**: The spacing between rows.
- **crossAxisSpacing**: The spacing between columns.
- **childAspectRatio**: The aspect ratio of each child.
- **scrollDirection**: The axis along which the grid scrolls.

### Quick Tips:
- Use for image galleries and grids.
- Use GridView.builder for large or infinite grids.


### Things to Avoid:
- Avoid using for lists—use ListView instead.
- Don’t forget to manage scroll controllers for custom behavior.

## Class Definition

```dart
class GridView extends BoxScrollView {
  GridView({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    required SliverGridDelegate gridDelegate,
    int? itemCount,
    IndexedWidgetBuilder? itemBuilder,
    List<Widget> children = const <Widget>[],
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
  }) : super(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          semanticChildCount: semanticChildCount,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
        );

  // ...
}
```
