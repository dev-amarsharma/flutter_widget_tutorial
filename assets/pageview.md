
# Page View

The `PageView` widget in Flutter displays a scrollable list of pages, one at a time. It is commonly used for onboarding screens and carousels.

## Class Definition

```dart
PageView({
  Key? key,
  Axis scrollDirection = Axis.horizontal,
  bool reverse = false,
  PageController? controller,
  ScrollPhysics? physics,
  bool pageSnapping = true,
  ValueChanged<int>? onPageChanged,
  List<Widget> children = const <Widget>[],
})
```

```dart
PageView(
  children: [
    Center(child: Text('Page 1')),
    Center(child: Text('Page 2')),
  ],
)
```

The main parameters of the PageView widget are:

- **children**: The list of pages to display.
- **controller**: Controls the page position.
- **scrollDirection**: The axis along which the pages scroll.
- **onPageChanged**: Callback when the page changes.

### Quick Tips:
- Use for onboarding, carousels, and tab views.
- Use PageController for custom behavior.

### Things to Avoid:
- Avoid using for lists—use ListView instead.
- Don’t forget to manage page controllers for custom behavior.
