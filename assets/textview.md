# Text Widget

The `Text` widget in Flutter displays a string of text with single style. It is one of the most commonly used widgets for showing static or dynamic text in your app.



## Class Definition

```dart
Text(
  String data, {
  Key? key,
  TextStyle? style,
  StrutStyle? strutStyle,
  TextAlign? textAlign,
  TextDirection? textDirection,
  Locale? locale,
  bool? softWrap,
  TextOverflow? overflow,
  double? textScaleFactor,
  TextScaler? textScaler,
  int? maxLines,
  String? semanticsLabel,
  TextWidthBasis? textWidthBasis,
  TextHeightBehavior? textHeightBehavior,
  Color? selectionColor,
})
```

## Example

```dart
Text(
  'Hello, Flutter!',
  style: TextStyle(
    fontSize: 20,
    color: Colors.deepPurple,
    fontWeight: FontWeight.bold,
  ),
  textAlign: TextAlign.center,
)
```

## Properties

| Property         | Description                                 |
|:---------------:|:--------------------------------------------:|
| data            | The string to display                        |
| style           | Controls the text's visual style             |
| textAlign       | How the text should be aligned horizontally  |
| maxLines        | Maximum number of lines for the text         |
| overflow        | How visual overflow should be handled        |
| softWrap        | Whether the text should break at soft line breaks |

## See Also
- [`Rich Text`](richtext.md): For displaying styled text with multiple styles.
- [`Default Text Style`](defaulttextstyle.md): To set default text style for descendants.
