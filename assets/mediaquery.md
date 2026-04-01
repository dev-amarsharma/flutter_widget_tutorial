# MediaQuery

Reads information about the current screen size, padding, and text scaling from the widget tree.

---

## Description

`MediaQuery` gives widgets access to environment data such as screen width, screen height, safe area padding, orientation, and text scale. It is useful when building responsive layouts that must adapt to different devices.

- **Common use cases:**
  - Reading screen width for layout decisions
  - Respecting device padding and insets
  - Adapting to portrait and landscape orientation
  - Responding to text scaling preferences

---

## Example

```dart
final size = MediaQuery.of(context).size;

Container(
  width: size.width * 0.8,
  height: 120,
  color: Colors.orange,
)
```

---

## Key Points

- `MediaQuery.of(context)` reads environment data from the widget tree.
- You can access screen size, padding, orientation, and more.
- It is useful for responsive sizing decisions.
- It should be used thoughtfully, not as a replacement for all layout widgets.

---

## Quick Tips

- Use `MediaQuery` for screen-level information.
- Pair it with widgets like `LayoutBuilder` for more precise layout logic.
- Test layouts on different screen sizes.

---

## Things to Avoid

- Avoid hardcoding sizes when layout should adapt.
- Avoid using screen width alone for every layout decision.
- Do not ignore safe area padding on devices with cutouts.

---

## See Also

- [`LayoutBuilder`](assets/layoutbuilder.md)
- [`Responsive Design Basics`](assets/responsive_design_basics.md)
