# Responsive Design Basics

Helps your Flutter UI adapt cleanly to different screen sizes and layouts.

---

## Description

Responsive design means building screens that work well on phones, tablets, and other form factors. In Flutter, this often involves:

- `MediaQuery`
- `LayoutBuilder`
- flexible layouts
- spacing that scales reasonably
- avoiding hard-coded dimensions when possible

---

## Example

```dart
Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final isWide = width > 600;

  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: isWide
          ? Row(
              children: const [
                Expanded(child: Text('Left panel')),
                SizedBox(width: 24),
                Expanded(child: Text('Right panel')),
              ],
            )
          : const Column(
              children: [
                Text('Top section'),
                SizedBox(height: 16),
                Text('Bottom section'),
              ],
            ),
    ),
  );
}
```

---

## Key Points

- Screen size affects layout choices.
- `Expanded`, `Flexible`, and `Wrap` help layouts adapt better.
- `MediaQuery` gives device dimensions and other screen info.
- `LayoutBuilder` helps respond to parent constraints.

---

## Quick Tips

- Design for narrow screens first, then expand for larger layouts.
- Use spacing and typography consistently across breakpoints.
- Test on more than one screen size.

---

## Things to Avoid

- Avoid relying too heavily on fixed pixel sizes.
- Do not assume one layout works everywhere.
- Avoid large overflows caused by rigid Row or Column layouts.

---

## See Also

- [`MediaQuery`](assets/mediaquery.md)
- [`LayoutBuilder`](assets/layoutbuilder.md)
- [`Wrap`](assets/wrap.md)
