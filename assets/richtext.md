# RichText Widget

The `RichText` widget in Flutter allows you to display text with multiple styles, colors, and spans within a single paragraph. It is highly flexible and is used for complex text layouts.

## Constructor
```dart
RichText({
  Key? key,
  required InlineSpan text,
  TextAlign textAlign = TextAlign.start,
  TextDirection? textDirection,
  bool softWrap = true,
  TextOverflow overflow = TextOverflow.clip,
  double textScaleFactor = 1.0,
  int? maxLines,
  Locale? locale,
  StrutStyle? strutStyle,
  TextWidthBasis textWidthBasis = TextWidthBasis.parent,
  TextHeightBehavior? textHeightBehavior,
})
```

## Example
```dart
RichText(
  text: TextSpan(
    text: 'Hello ',
    style: TextStyle(color: Colors.black, fontSize: 18),
    children: <TextSpan>[
      TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(text: ' world!', style: TextStyle(color: Colors.blue)),
    ],
  ),
)
```

## Key Points
- Use `TextSpan` and its `children` to compose rich text.
- Each `TextSpan` can have its own style.
- Useful for inline links, mixed styles, and custom text effects.

## When to Use
- When you need more than one style in a single text block.
- For inline links, colored or bolded words, or custom text effects.

---
[Flutter Docs: RichText](https://api.flutter.dev/flutter/widgets/RichText-class.html)
