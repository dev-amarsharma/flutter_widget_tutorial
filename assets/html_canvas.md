# Canvas

## Overview
The `<canvas>` element creates a drawing surface that JavaScript can paint pixel-based graphics onto.
Canvas is used for charts, games, animations, custom visualizations, and other dynamic graphics.

## Why this topic matters
Knowing canvas helps you build rich interactive experiences in the browser, especially when HTML and CSS alone are not enough.
It also teaches how to combine markup with JavaScript and rendering performance techniques.

## Core concepts
- `<canvas>` provides a bitmap drawing area defined by `width` and `height`.
- The `getContext('2d')` API gives access to drawing methods like `fillRect`, `stroke`, and `drawImage`.
- Canvas is resolution-dependent and must be redrawn each frame.
- It is not semantic content, so accessibility and fallback content are important.

## Key syntax
```html
<canvas id="drawing" width="400" height="300">
  Your browser does not support the canvas element.
</canvas>
```

```js
const canvas = document.getElementById('drawing');
const ctx = canvas.getContext('2d');
ctx.fillStyle = '#007acc';
ctx.fillRect(50, 50, 150, 100);
```

### Important canvas properties
- `width` and `height` — define the internal pixel dimensions of the canvas.
- `style.width` and `style.height` — control the display size in CSS.
- `getContext('2d')` — returns the 2D rendering context.

---

## Common drawing operations
- `fillRect(x, y, w, h)` — draw a filled rectangle.
- `strokeRect(x, y, w, h)` — draw a rectangle outline.
- `beginPath()`, `moveTo()`, `lineTo()`, `stroke()` — draw lines.
- `arc(x, y, radius, startAngle, endAngle)` — draw circles.
- `fillText(text, x, y)` — render text.
- `drawImage(image, x, y)` — paint an image onto the canvas.

---

## Accessibility and fallbacks
1. Provide fallback content inside `<canvas>` for unsupported browsers.
2. Use captions or text descriptions alongside the canvas when it displays important information.
3. Keep core functionality available without canvas if possible.
4. Avoid relying on canvas for content that needs search, selection, or assistive technology.

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Canvas Example</title>
    <style>
      canvas { border: 1px solid #ccc; display: block; margin: 1rem 0; }
    </style>
  </head>
  <body>
    <h1>Canvas drawing example</h1>

    <canvas id="drawing" width="400" height="200">
      Your browser does not support the canvas element.
    </canvas>

    <p>
      This canvas draws a blue rectangle, a line, and some text using the 2D rendering context.
    </p>

    <script>
      const canvas = document.getElementById('drawing');
      const ctx = canvas.getContext('2d');

      ctx.fillStyle = '#007acc';
      ctx.fillRect(20, 20, 180, 100);

      ctx.strokeStyle = '#333';
      ctx.lineWidth = 4;
      ctx.beginPath();
      ctx.moveTo(230, 40);
      ctx.lineTo(380, 140);
      ctx.stroke();

      ctx.fillStyle = '#111';
      ctx.font = '20px Arial';
      ctx.fillText('Canvas demo', 30, 160);
    </script>
  </body>
</html>
```

---

## Common mistakes to avoid
- Forgetting the `width` and `height` attributes and relying only on CSS size.
- Treating canvas as semantic content.
- Not providing fallback text for unsupported browsers.
- Drawing with the wrong coordinate system or forgetting to clear before redrawing.
- Overusing canvas when SVG or CSS could solve the same problem more simply.

---

## Quick practice
1. Create a `<canvas>` with `width` and `height` attributes.
2. Draw a filled rectangle and a line with canvas 2D context methods.
3. Add fallback text inside the `<canvas>` element.
4. Use CSS to style the canvas border and spacing.

---

## Official references
- MDN: `<canvas>` element: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/canvas
- MDN: Canvas API basics: https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API
- WHATWG: Canvas element reference: https://html.spec.whatwg.org/multipage/canvas.html
