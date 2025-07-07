
# Stack

The `Stack` widget in Flutter allows you to overlay widgets on top of each other. It is commonly used for complex layouts where widgets need to overlap or be positioned relative to each other.

## Class Definition

```dart
Stack({
  Key? key,
  AlignmentGeometry alignment = AlignmentDirectional.topStart,
  TextDirection? textDirection,
  StackFit fit = StackFit.loose,
  Clip clipBehavior = Clip.hardEdge,
  List<Widget> children = const <Widget>[],
})
```

```dart
Stack(
  children: [
    Container(width: 100, height: 100, color: Colors.red),
    Positioned(
      top: 10,
      left: 10,
      child: Icon(Icons.star, color: Colors.yellow),
    ),
  ],
)
```

The main parameters of the Flutter Stack widget are:

- **children**: The list of widgets to overlay (required).
- **alignment**: How to align non-positioned children within the stack.
- **fit**: How to size the non-positioned children.
- **clipBehavior**: How to clip children that overflow the stack.

### Quick Tips:
- Use `Positioned` to control the position of children inside a Stack.
- Combine Stack with `Align` for flexible overlays.

### Things to Avoid:
- Avoid using Stack for simple layouts; prefer `Row` or `Column`.
- Don’t forget to handle overflow if children exceed the Stack’s bounds.
