# Display & Visibility

## Overview
The `display` property is the most fundamental layout control in CSS. It determines whether an element starts a new line, flows inline with text, or disappears entirely. Understanding `display`, `visibility`, and `overflow` lets you control exactly what shows up and how it flows in the page.

---

## Why this topic matters
Every layout decision in CSS starts with `display`. Knowing the difference between `block`, `inline`, and `inline-block` prevents many common spacing and alignment bugs.

## display: block
Block elements take up the full available width and start on a new line.

```css
div, p, h1, section { display: block; } /* already block by default */

.full-width {
  display: block;
  width: 100%;
  padding: 16px;
  background: lightblue;
}
```
- Always starts on a new line
- Respects `width`, `height`, `padding`, `margin` on all sides

---

## display: inline
Inline elements flow with text and do not start a new line.

```css
span, a, strong { display: inline; } /* already inline by default */

.tag {
  display: inline;
  color: white;
  background: navy;
  padding: 2px 6px; /* only horizontal padding is reliable */
}
```
- Does NOT respect `width`/`height`
- Vertical margin has no effect; vertical padding may overlap adjacent lines

---

## display: inline-block
A hybrid: flows inline but respects block-level sizing properties.

```css
.badge {
  display: inline-block;
  width: 80px;
  height: 24px;
  padding: 4px 8px;
  background: coral;
  border-radius: 4px;
}
```
- Stays in the text flow (no forced line break)
- Fully respects `width`, `height`, `margin`, `padding`

---

## display: none
Removes the element completely from the layout — it takes up no space.

```css
.hidden { display: none; }
.modal  { display: none; }
.modal.active { display: block; }
```

---

## visibility: hidden vs display: none
```css
.invisible { visibility: hidden; } /* hides but KEEPS the space */
.gone      { display: none; }      /* hides and REMOVES the space */
```

---

## overflow
Controls what happens when content exceeds its container's size.

```css
.box {
  width: 200px;
  height: 100px;
  overflow: hidden;   /* clips the overflow */
  /* overflow: scroll;  always shows scrollbars */
  /* overflow: auto;    scrollbar only when needed */
  /* overflow: visible; default — content spills out */
}
```

---

## Float basics
Originally for text-wrap layouts; still used occasionally:

```css
.image-left {
  float: left;
  margin-right: 16px;
}

/* Clear a float so parent container wraps around it */
.clearfix::after {
  content: '';
  display: block;
  clear: both;
}
```
For modern layouts, prefer Flexbox or Grid over floats.

---

## Common mistakes to avoid
- Adding `width`/`height` to an `inline` element (has no effect)
- Confusing `display: none` and `visibility: hidden` (space behavior differs)
- Forgetting to clear floats, causing parent height collapse
- Setting `overflow: hidden` and then wondering why position:absolute children disappear

---

## Quick practice
1. Create a row of three `<span>` tags and make them `inline-block` with a fixed `width`
2. Toggle a `<div>` between `display: none` and `display: block` using a second CSS class
3. Create a container with `height: 80px; overflow: auto` and put more text inside it
4. Float an image to the left and wrap text around it, then apply a clearfix
5. Compare `visibility: hidden` vs `display: none` by inspecting the page layout in DevTools

---

## Official references
- MDN: display: https://developer.mozilla.org/en-US/docs/Web/CSS/display
- MDN: overflow: https://developer.mozilla.org/en-US/docs/Web/CSS/overflow
- MDN: float: https://developer.mozilla.org/en-US/docs/Web/CSS/float
