# SVG

## Overview
SVG (Scalable Vector Graphics) is XML-based vector image markup.
It is ideal for icons, illustrations, and graphics that need to scale cleanly at any resolution.

## Why this topic matters
SVG keeps visuals sharp on high-resolution displays and allows styling or animation with CSS and JavaScript.
It is often smaller than bitmap images and is useful for responsive, accessible graphics.

---

## SVG basics
```html
<svg width="100" height="100" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
  <circle cx="50" cy="50" r="40" fill="#007acc" />
</svg>
```

### Key SVG elements
- `<svg>` — root container.
- `<circle>` — draws a circle.
- `<rect>` — draws a rectangle.
- `<line>` — draws a straight line.
- `<path>` — draws complex shapes.
- `<text>` — renders text.

---

## Using SVG in HTML
Inline SVG:
```html
<svg width="80" height="80" viewBox="0 0 80 80" xmlns="http://www.w3.org/2000/svg">
  <rect x="10" y="10" width="60" height="60" fill="#4caf50" />
</svg>
```

SVG file reference:
```html
<img src="logo.svg" alt="Company logo">
```

---

## Accessibility and best practices
1. Use `role="img"` and `aria-label` or `<title>` inside SVG when the graphic conveys meaning.
2. Provide `alt` text when using SVG with `<img>`.
3. Use `viewBox` for scalable graphics.
4. Keep SVG markup clean and avoid unnecessary metadata.
5. Prefer inline SVG for styling or animation, and external SVG for reusable assets.

---

## Real example

```html
<svg width="120" height="120" viewBox="0 0 120 120" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Green check mark">
  <title>Green check mark</title>
  <circle cx="60" cy="60" r="50" fill="#4caf50" />
  <polyline points="40,65 55,80 80,40" fill="none" stroke="#fff" stroke-width="10" stroke-linecap="round" stroke-linejoin="round" />
</svg>
```

---

## Common mistakes to avoid
- Forgetting `viewBox` for responsive scaling.
- Using SVG files without accessible labels.
- Relying on raster images for simple icons.
- Embedding unnecessary CSS or script inside a simple SVG.
- Placing large SVG files inline when a referenced asset is more appropriate.

---

## Quick practice
1. Draw an SVG circle and rectangle with `viewBox`.
2. Add a `<title>` for accessibility.
3. Use an external SVG file with an `<img>` tag.
4. Apply a simple CSS fill color to inline SVG.

---

## Official references
- MDN: SVG overview: https://developer.mozilla.org/en-US/docs/Web/SVG
- MDN: SVG in HTML: https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial/Basic_Shapes
