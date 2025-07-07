## Tooltip

In Flutter, the Tooltip widget displays a message when the user long-presses or hovers over a widget. It is commonly used for accessibility and hints.

```dart
Tooltip(
  message: 'This is a tooltip',
  child: Icon(Icons.info),
)
```

The main parameters of the Flutter Tooltip widget are:

- **message**: The text to display (required).
- **child**: The widget to which the tooltip applies (required).
- **decoration**: The decoration of the tooltip.
- **textStyle**: The style of the tooltip text.
- **preferBelow**: Whether to display the tooltip below the widget.

### Quick Tips:
- Use for icons and buttons to provide extra info.
- Keep messages short and clear.


### Things to Avoid:
- Avoid overusing tooltips.
- Don’t use for essential information.

## Class Definition

```dart
class Tooltip extends StatefulWidget {
  const Tooltip({
    Key? key,
    required this.message,
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset = 24.0,
    this.preferBelow = true,
    this.excludeFromSemantics = false,
    this.decoration,
    this.textStyle,
    this.waitDuration,
    this.showDuration,
    this.triggerMode,
    this.enableFeedback = true,
    this.child,
  }) : super(key: key);

  final String message;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double verticalOffset;
  final bool preferBelow;
  final bool excludeFromSemantics;
  final Decoration? decoration;
  final TextStyle? textStyle;
  final Duration? waitDuration;
  final Duration? showDuration;
  final TooltipTriggerMode? triggerMode;
  final bool enableFeedback;
  final Widget? child;

  @override
  State<Tooltip> createState() => _TooltipState();
}
```
