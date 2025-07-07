## StatefulWidget

In Flutter, the StatefulWidget is a widget that has mutable state. It is commonly used when the UI can change dynamically.

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Text('Count: $counter');
  }
}
```

The main parameters of the StatefulWidget are:

- **createState**: Returns the mutable state for this widget (required).

### Quick Tips:
- Use for widgets that need to update their UI.
- Keep state logic in the State class.


### Things to Avoid:
- Avoid putting business logic in the widget class.
- Don’t forget to call setState when updating state.

## Class Definition

```dart
abstract class StatefulWidget extends Widget {
  const StatefulWidget({ Key? key }) : super(key: key);

  @protected
  State createState();
}
```
