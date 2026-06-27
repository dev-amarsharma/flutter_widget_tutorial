# CSS Box Model

## Overview
Every HTML element is rendered as a rectangular box. The CSS box model describes the layers that make up that box: content, padding, border, and margin. Understanding this model is essential for controlling spacing and sizing in any layout.

---

## Why this topic matters
Misunderstanding the box model is the source of many layout bugs. Once you grasp how the layers interact — especially `box-sizing` — you can predict exactly how much space an element occupies.

## The four layers
```
┌─────────────────────────────┐
│          MARGIN              │  (outside the border, transparent)
│  ┌───────────────────────┐  │
│  │        BORDER          │  │  (visible frame around the element)
│  │  ┌─────────────────┐  │  │
│  │  │     PADDING      │  │  │  (space inside border, background-colored)
│  │  │  ┌───────────┐  │  │  │
│  │  │  │  CONTENT  │  │  │  │  (width × height of actual content)
│  │  │  └───────────┘  │  │  │
│  │  └─────────────────┘  │  │
│  └───────────────────────┘  │
└─────────────────────────────┘
```

```css
.card {
  width: 300px;
  padding: 20px;          /* inside space (all sides) */
  border: 2px solid #ccc; /* visible line around content+padding */
  margin: 16px;           /* outside space (all sides) */
  background: white;      /* fills content + padding area */
}
```

### Key parts
- **content** — where text and child elements live; sized by `width`/`height`
- **padding** — transparent inner cushion; inherits background color
- **border** — drawn on the edge of padding; can have color, style, width
- **margin** — transparent outer space; collapses between adjacent blocks

---

## box-sizing
By default, `width` applies only to the **content box**. Padding and border add on top, making elements wider than expected.

```css
/* Default — content-box: total = width + padding + border */
.default-box {
  box-sizing: content-box; /* 300 + 40 + 4 = 344px total */
  width: 300px;
  padding: 20px;
  border: 2px solid black;
}

/* Border-box: total = width (padding + border included inside) */
.border-box {
  box-sizing: border-box; /* stays exactly 300px */
  width: 300px;
  padding: 20px;
  border: 2px solid black;
}
```

Most developers apply this globally:
```css
*, *::before, *::after {
  box-sizing: border-box;
}
```

---

## Shorthand for padding and margin
```css
.element {
  /* One value: all four sides */
  padding: 10px;

  /* Two values: top/bottom, left/right */
  margin: 20px 10px;

  /* Three values: top, left/right, bottom */
  padding: 10px 20px 30px;

  /* Four values: top, right, bottom, left (clockwise) */
  margin: 10px 20px 30px 40px;
}
```

---

## Margin collapse
Adjacent vertical margins between block elements collapse into a single margin equal to the larger value.

```css
.top    { margin-bottom: 30px; }
.bottom { margin-top: 20px; }
/* Actual gap = 30px, not 50px */
```

---

## Common mistakes to avoid
- Not setting `box-sizing: border-box` globally and getting unexpected widths
- Expecting padding to be transparent (it inherits background, but border does not)
- Relying on margin collapse behavior without understanding it
- Using `margin: auto` on non-block elements (it has no effect on inline elements)

---

## Quick practice
1. Create a `<div>` with `width: 200px`, `padding: 20px`, `border: 5px solid blue`, `margin: 30px`
2. Inspect it in browser DevTools and note the total rendered width under `content-box`
3. Add `box-sizing: border-box` and observe how the rendered width changes
4. Try the `margin` shorthand with two values and four values, verifying the spacing changes
5. Stack two boxes with different `margin-bottom`/`margin-top` values and observe collapse

---

## Official references
- MDN: The box model: https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/The_box_model
- MDN: box-sizing: https://developer.mozilla.org/en-US/docs/Web/CSS/box-sizing
