# Table Widget

The `Table` widget in Flutter allows you to arrange widgets in a grid of rows and columns, similar to an HTML table.

## Example

```dart
Table(
  border: TableBorder.all(),
  children: [
    TableRow(children: [
      Text('Row 1, Col 1'),
      Text('Row 1, Col 2'),
    ]),
    TableRow(children: [
      Text('Row 2, Col 1'),
      Text('Row 2, Col 2'),
    ]),
  ],
)
```

## Properties

| Property      | Description                                 |
|:------------:|:--------------------------------------------:|
| children     | List of TableRow widgets (rows of the table) |
| border       | TableBorder for the table outline            |
| columnWidths | Map to specify column widths                 |
| defaultColumnWidth | Default width for columns              |
| textDirection| Text direction for the table                 |


## Class Definition

```dart
class Table extends RenderObjectWidget {
  const Table({
    Key? key,
    this.children = const <TableRow>[],
    this.columnWidths,
    this.defaultColumnWidth = const FlexColumnWidth(),
    this.textDirection,
    this.border,
    this.defaultVerticalAlignment = TableCellVerticalAlignment.top,
    this.textBaseline,
    this.clipBehavior = Clip.none,
  }) : super(key: key);

  // ...
}
```

## See Also
- [`DataTable`](datatable.md): For displaying data in a table format with sorting and pagination.
- [`Row`](row.md), [`Column`](column.md): For simpler layouts.
