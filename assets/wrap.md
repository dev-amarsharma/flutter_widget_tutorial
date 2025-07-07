## Wrap

In Flutter, the Wrap widget displays its children in multiple horizontal or vertical runs. It automatically wraps to the next line or column when there is not enough space.

```dart
Wrap(
  spacing: 8,
  runSpacing: 4,
  children: [
    Chip(label: Text('One')),
    Chip(label: Text('Two')),
    Chip(label: Text('Three')),
  ],
)
```

The main parameters of the Flutter Wrap widget are:

- **children**: The list of widgets to display (required).
- **direction**: The direction to arrange children (horizontal or vertical).
- **spacing**: The space between children in the main axis.
- **runSpacing**: The space between lines or runs.
- **alignment**: How to align children within a run.
- **runAlignment**: How to align runs within the wrap.

### Quick Tips:
- Use Wrap for chips, tags, or any content that may overflow a single line.
- Adjust `spacing` and `runSpacing` for better layout.


### Things to Avoid:
- Avoid using Wrap for simple one-line layouts; use Row or Column instead.
- Don’t use Wrap for scrollable content—use ListView or GridView.

## Class Definition

```dart
class Wrap extends MultiChildRenderObjectWidget {
  const Wrap({
    Key? key,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.spacing = 0.0,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
    List<Widget> children = const <Widget>[],
  }) : super(key: key, children: children);

  // ...
}
```
