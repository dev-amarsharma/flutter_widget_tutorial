# CSS Grid

## Overview
CSS Grid is a two-dimensional layout system that works with both rows and columns simultaneously. While Flexbox handles one axis at a time, Grid lets you define a full layout structure and place items precisely — or let them auto-flow into the right positions.

---

## Why this topic matters
Grid enables page-level layouts (header, sidebar, main, footer) and complex card arrangements that would be cumbersome with Flexbox alone. It's the most powerful layout tool in CSS.

## Defining a grid container
```css
.grid {
  display: grid;
  grid-template-columns: 200px 1fr 1fr; /* 3 columns */
  grid-template-rows: auto;             /* rows size to content */
  gap: 16px;                            /* gap between all cells */
}
```

### Key parts
- `grid-template-columns` — defines the number and size of columns
- `grid-template-rows` — defines row sizes
- `gap` (or `column-gap` / `row-gap`) — spacing between grid cells

---

## The fr unit
`fr` (fractional) distributes the remaining free space after fixed sizes are allocated.

```css
.grid {
  grid-template-columns: 300px 1fr 2fr;
  /* column 1: fixed 300px
     column 2: 1 share of remaining space
     column 3: 2 shares of remaining space */
}
```

---

## repeat() and auto-fill / auto-fit
```css
/* Explicit: 4 equal columns */
.grid { grid-template-columns: repeat(4, 1fr); }

/* auto-fill: creates as many columns as fit, even empty ones */
.responsive {
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
}

/* auto-fit: same but collapses empty columns so items stretch */
.responsive {
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
}
```

---

## Placing items with grid-column and grid-row
Grid lines are numbered starting at 1.

```css
.header {
  grid-column: 1 / -1; /* span all columns (from line 1 to last line) */
  grid-row: 1;
}

.sidebar {
  grid-column: 1;       /* only first column */
  grid-row: 2 / 4;     /* spans rows 2 and 3 */
}

.main {
  grid-column: 2 / -1; /* columns 2 to end */
  grid-row: 2;
}
```

---

## Named grid areas
```css
.layout {
  display: grid;
  grid-template-areas:
    "header  header"
    "sidebar main  "
    "footer  footer";
  grid-template-columns: 240px 1fr;
  grid-template-rows: 60px 1fr 40px;
}

header  { grid-area: header; }
aside   { grid-area: sidebar; }
main    { grid-area: main; }
footer  { grid-area: footer; }
```

---

## align-items and justify-items
```css
.grid {
  justify-items: center;  /* align items horizontally within their cell */
  align-items: center;    /* align items vertically within their cell */
}

.item {
  justify-self: start;    /* override for a single item (horizontal) */
  align-self: end;        /* override for a single item (vertical) */
}
```

---

## Common mistakes to avoid
- Confusing grid lines with track numbers (`grid-column: 1 / 3` is 2 columns wide)
- Using `auto-fill` when you want `auto-fit` (or vice versa — know the difference)
- Not adding `gap` and wondering why cells are touching
- Using Grid for simple single-axis layouts where Flexbox is simpler

---

## Quick practice
1. Create a 3-column card grid using `repeat(3, 1fr)` with `gap: 24px`
2. Make a named-areas layout with header, sidebar, main content, and footer
3. Try `repeat(auto-fit, minmax(250px, 1fr))` and resize the browser to see responsive columns
4. Span the header across all columns using `grid-column: 1 / -1`
5. Use `align-self: end` on one card to see it anchor to the bottom of its row

---

## Official references
- MDN: CSS Grid Layout: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_grid_layout
- MDN: grid-template-areas: https://developer.mozilla.org/en-US/docs/Web/CSS/grid-template-areas
