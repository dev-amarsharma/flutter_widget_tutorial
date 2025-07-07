
# Column

The `Column` widget in Flutter arranges its children vertically in a single line. It is commonly used to stack widgets on top of each other. You can control alignment, spacing, and how children expand to fill available space.

## Class Definition

```dart
Column({
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
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Icon(Icons.star, color: Colors.orange),
    SizedBox(height: 8),
    Text('Starred'),
  ],
)
```

The main parameters of the Flutter Column widget are:

- **children**: The list of widgets to display vertically (required).
- **mainAxisAlignment**: How to align children vertically (e.g., start, center, end, spaceBetween).
- **crossAxisAlignment**: How to align children horizontally.
- **mainAxisSize**: Whether the column takes up all available vertical space or just enough for its children.
- **textDirection**: The direction to arrange children (left-to-right or right-to-left).
- **verticalDirection**: The order in which children are placed vertically.
- **textBaseline**: Used for aligning text when crossAxisAlignment is baseline.


### Quick Tips:
- Use `Expanded` or `Flexible` for children that should share available space.
- Set `mainAxisAlignment` and `crossAxisAlignment` to control alignment and spacing.
- Use `SizedBox` or `Spacer` to add gaps between children.

### Things to Avoid:
- Avoid placing too many widgets in a Column, as they may overflow the screen.
- Don’t forget to handle overflow—if children are too tall, use `Expanded`, `Flexible`, or wrap the Column in a `SingleChildScrollView`.
- Avoid mixing widgets with different widths unless you control horizontal alignment with `crossAxisAlignment`.
