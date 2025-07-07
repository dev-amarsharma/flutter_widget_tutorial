
# Row

The `Row` widget in Flutter arranges its children horizontally in a single line. It is commonly used to place widgets side by side. You can control alignment, spacing, and how children expand to fill available space.

## Class Definition

```dart
Row({
  Key? key,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  MainAxisSize mainAxisSize = MainAxisSize.max,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  TextDirection? textDirection,
  VerticalDirection verticalDirection = VerticalDirection.down,
  TextBaseline? textBaseline,
  List<Widget> children = const <Widget>[],
})
```

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Icon(Icons.star, color: Colors.orange),
    SizedBox(width: 8),
    Text('Starred'),
  ],
)
```

The main parameters of the Flutter Row widget are:

- **children**: The list of widgets to display horizontally (required).
- **mainAxisAlignment**: How to align children horizontally (e.g., start, center, end, spaceBetween).
- **crossAxisAlignment**: How to align children vertically.
- **mainAxisSize**: Whether the row takes up all available horizontal space or just enough for its children.
- **textDirection**: The direction to arrange children (left-to-right or right-to-left).
- **verticalDirection**: The order in which children are placed vertically.
- **textBaseline**: Used for aligning text when crossAxisAlignment is baseline.


### Quick Tips:
- Use `Expanded` or `Flexible` for children that should share available space.
- Set `mainAxisAlignment` and `crossAxisAlignment` to control alignment and spacing.
- Use `SizedBox` or `Spacer` to add gaps between children.

### Things to Avoid:
- Avoid placing too many widgets in a Row, as they may overflow the screen.
- Don’t forget to handle overflow—if children are too wide, use `Expanded`, `Flexible`, or wrap the Row in a `SingleChildScrollView`.
- Avoid mixing widgets with different heights unless you control vertical alignment with `crossAxisAlignment`.