# DefaultTextStyle

Establishes a default text style for its descendants.

---

## Description

The `DefaultTextStyle` widget defines the default text style for the subtree below it. All descendant `Text` widgets without an explicit style will inherit this style. This is useful for setting a consistent text appearance for a section of your widget tree.

- **Common use cases:**
  - Applying a consistent text style to a group of widgets
  - Overriding the inherited text style in a subtree

---

## Example

```dart
DefaultTextStyle(
  style: const TextStyle(
    color: Colors.deepOrange,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  child: Column(
    children: const [
      Text('This is bold and orange!'),
      Text('So is this!'),
    ],
  ),
)
```

---

## Class Definition

```dart
class DefaultTextStyle extends InheritedTheme {
  const DefaultTextStyle({
    Key? key,
    required this.style,
    this.textAlign,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
    required Widget child,
  }) : super(key: key, child: child);

  final TextStyle style;
  final TextAlign? textAlign;
  final bool softWrap;
  final TextOverflow overflow;
  final int? maxLines;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  // ...
}
```

---

## Properties

| Name                  | Type                | Description                                      |
|-----------------------|---------------------|--------------------------------------------------|
| `style`               | TextStyle           | The default text style.                          |
| `textAlign`           | TextAlign?          | How to align the text.                           |
| `softWrap`            | bool                | Whether the text should break at soft line breaks.|
| `overflow`            | TextOverflow        | How visual overflow should be handled.            |
| `maxLines`            | int?                | Maximum number of lines for the text.             |
| `textWidthBasis`      | TextWidthBasis      | How to measure the width of the text.             |
| `textHeightBehavior`  | TextHeightBehavior? | How to apply height to the text.                  |
| `child`               | Widget              | The widget below this widget in the tree.         |

---

## See Also

- [Official DefaultTextStyle docs](https://api.flutter.dev/flutter/widgets/DefaultTextStyle-class.html)
