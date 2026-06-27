# Flexbox

## Overview
Flexbox is a one-dimensional layout model that makes it easy to align and distribute space among items in a row or column. With a handful of properties on the container and items, you can build navigation bars, card grids, centered content, and complex responsive layouts without floats or hacks.

---

## Why this topic matters
Flexbox replaced float-based layouts and is now the go-to tool for component-level layout. Every modern web developer uses it daily for aligning items and distributing space.

## Setting up a flex container
```css
.container {
  display: flex; /* enables flex layout for direct children */
}
```
All direct children become **flex items**.

---

## flex-direction
```css
.row     { flex-direction: row; }            /* default: left → right */
.row-rev { flex-direction: row-reverse; }    /* right → left */
.col     { flex-direction: column; }         /* top → bottom */
.col-rev { flex-direction: column-reverse; } /* bottom → top */
```

---

## justify-content (main axis)
```css
.container {
  justify-content: flex-start;    /* default: pack to start */
  justify-content: flex-end;      /* pack to end */
  justify-content: center;        /* center items */
  justify-content: space-between; /* even gaps, no edge space */
  justify-content: space-around;  /* even gaps, half-gap at edges */
  justify-content: space-evenly;  /* perfectly even gaps including edges */
}
```

---

## align-items (cross axis)
```css
.container {
  align-items: stretch;     /* default: fill cross-axis */
  align-items: flex-start;  /* align to start of cross axis */
  align-items: flex-end;    /* align to end */
  align-items: center;      /* center on cross axis */
  align-items: baseline;    /* align by text baseline */
}
```

---

## Centering an element (classic use case)
```css
.center-me {
  display: flex;
  justify-content: center; /* horizontal center */
  align-items: center;     /* vertical center */
  height: 100vh;
}
```

---

## flex-wrap
```css
.container {
  flex-wrap: nowrap;   /* default: items shrink to fit one line */
  flex-wrap: wrap;     /* items wrap to next line when they overflow */
  flex-wrap: wrap-reverse; /* wraps in reverse direction */
}
```

---

## gap
```css
.container {
  display: flex;
  gap: 16px;          /* space between all items */
  gap: 8px 16px;      /* row-gap column-gap */
}
```

---

## Flex item properties
```css
.item {
  flex-grow: 1;   /* grow to fill available space (proportion) */
  flex-shrink: 1; /* shrink when space is tight (default: 1) */
  flex-basis: 200px; /* starting size before grow/shrink */

  /* shorthand */
  flex: 1;           /* grow:1 shrink:1 basis:0 */
  flex: 0 0 200px;   /* don't grow, don't shrink, base 200px */
}

.item-2 {
  align-self: flex-start; /* override container's align-items for this item */
  order: -1;              /* control render order without changing HTML */
}
```

---

## Common mistakes to avoid
- Forgetting to set `display: flex` on the **parent** container (not the items)
- Confusing main axis and cross axis (direction changes with `flex-direction`)
- Using `width: 100%` on flex items when `flex-grow: 1` is more appropriate
- Not adding `flex-wrap: wrap` when items need to wrap on smaller screens

---

## Quick practice
1. Create a `<nav>` with five links and use Flexbox to spread them with `space-between`
2. Build a 3-card row where each card uses `flex: 1` to share space equally
3. Center a modal dialog both vertically and horizontally in a full-viewport container
4. Add `flex-wrap: wrap` and resize the browser to see items wrap to the next line
5. Use `order` to move the last card to the first position without changing HTML

---

## Official references
- MDN: Flexbox: https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Flexbox
- MDN: flex: https://developer.mozilla.org/en-US/docs/Web/CSS/flex
