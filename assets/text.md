# Text

The `Text` widget in Flutter is used to display a string of text with a
single style. It is one of the most commonly used widgets and supports
styling, alignment, overflow handling, and text scaling.

## Class Definition

``` dart
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
  int? maxLines,
  String? semanticsLabel,
  TextWidthBasis? textWidthBasis,
  TextHeightBehavior? textHeightBehavior,
})
```

## Example

``` dart
Text(
  'Hello Flutter',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.blue,
  ),
)
```

## Parameters

-   **data**: The string of text to display (required).
-   **style**: Controls text appearance such as font size, weight,
    color, and letter spacing.
-   **textAlign**: How the text should be aligned horizontally (left,
    right, center, justify).
-   **textDirection**: The directionality of the text (LTR or RTL).
-   **softWrap**: Whether the text should break at soft line breaks.
-   **overflow**: How visual overflow should be handled (clip, fade,
    ellipsis, visible).
-   **maxLines**: The maximum number of lines for the text to span.
-   **textScaleFactor**: Scales the text size based on device
    accessibility settings.
-   **locale**: Used to select region-specific glyphs.
-   **semanticsLabel**: An alternative text description for
    accessibility tools.
-   **textWidthBasis**: How to calculate the width of the text.
-   **textHeightBehavior**: How the height of the text should be
    applied.

## Quick Tips

-   Use `TextStyle` to keep your text styling consistent across the app.
-   Prefer `maxLines` with `overflow: TextOverflow.ellipsis` for long
    text.
-   Use `MediaQuery.textScaleFactor` awareness for
    accessibility-friendly apps.
-   Wrap text inside `Flexible` or `Expanded` when used in `Row` or
    `Column`.

## Things to Avoid

-   Avoid hardcoding large font sizes without considering text scaling.
-   Don't ignore overflow handling when displaying dynamic text.
-   Avoid rebuilding heavy text widgets unnecessarily in
    performance-critical lists.
-   Don't mix multiple text styles in a single `Text` widget---use
    `RichText` instead.
