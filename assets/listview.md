
# List View

The `ListView` widget in Flutter displays a scrollable list of widgets. It is commonly used for lists of items.

## Class Definition

```dart
ListView({
  Key? key,
  Axis scrollDirection = Axis.vertical,
  bool reverse = false,
  ScrollController? controller,
  bool? primary,
  ScrollPhysics? physics,
  bool shrinkWrap = false,
  EdgeInsetsGeometry? padding,
  double? itemExtent,
  Widget? prototypeItem,
  List<Widget> children = const <Widget>[],
})
```

```dart
ListView(
  children: [
    ListTile(title: Text('Item 1')),
    ListTile(title: Text('Item 2')),
  ],
)
```

The main parameters of the ListView widget are:

- **children**: The list of widgets to display.
- **itemBuilder**: Function to build children on demand.
- **itemCount**: Number of items.
- **scrollDirection**: The axis along which the list scrolls.
- **controller**: Controls the scroll position.

### Quick Tips:
- Use for vertical or horizontal lists.
- Use ListView.builder for large or infinite lists.

### Things to Avoid:
- Avoid using for grids—use GridView instead.
- Don’t forget to manage scroll controllers for custom behavior.
