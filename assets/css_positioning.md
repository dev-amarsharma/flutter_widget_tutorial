# CSS Positioning

## Overview
CSS positioning controls where an element is placed on the page and how it interacts with surrounding elements. From the default static flow to sticky headers that pin while scrolling, the `position` property plus `top`, `right`, `bottom`, and `left` offsets give you precise control over placement.

---

## Why this topic matters
Positioning is essential for tooltips, modals, dropdowns, sticky navigation bars, overlays, and any component that needs to be taken out of normal document flow or pinned to a specific location.

## position: static (default)
```css
.box {
  position: static; /* default — normal document flow */
  /* top, right, bottom, left have NO effect here */
}
```

---

## position: relative
Stays in normal flow, but can be offset from where it *would* have appeared. The original space is preserved.

```css
.offset-box {
  position: relative;
  top: 10px;  /* moves DOWN 10px from its natural position */
  left: 20px; /* moves RIGHT 20px */
}
```

Also used as a **positioning context** (anchor) for absolutely positioned children.

---

## position: absolute
Removed from normal flow. Positioned relative to the nearest **ancestor that has a non-static `position`**. If none exists, it's relative to the initial containing block (the viewport).

```css
.parent {
  position: relative; /* establishes positioning context */
}

.badge {
  position: absolute;
  top: 8px;
  right: 8px;
  /* positioned in the top-right corner of .parent */
}
```

---

## position: fixed
Removed from normal flow. Positioned relative to the **viewport** — stays in place during scrolling.

```css
.navbar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  z-index: 100;
  background: white;
}
```

---

## position: sticky
Stays in normal flow until it reaches a specified scroll threshold, then "sticks" in place.

```css
.table-header {
  position: sticky;
  top: 0; /* sticks when it reaches the top of the viewport */
  background: white;
  z-index: 10;
}
```

A `top` (or `left`/`right`/`bottom`) offset is required for sticky to work.

---

## z-index and stacking context
`z-index` controls which element appears on top when elements overlap.

```css
.modal {
  position: fixed;
  z-index: 1000; /* higher = in front */
}

.overlay {
  position: fixed;
  z-index: 999; /* behind the modal */
}

.navbar {
  position: fixed;
  z-index: 100;
}
```

### Stacking context rules
- `z-index` only works on positioned elements (`position` ≠ `static`)
- Each element with `z-index` and a non-static position creates a new stacking context
- Children cannot escape their parent's stacking context
- Transforms, opacity < 1, and `will-change` also create new stacking contexts

---

## Centering with absolute positioning
```css
.centered {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%); /* offset by half its own size */
}
```

---

## Common mistakes to avoid
- Forgetting to add `position: relative` to the parent when using `position: absolute`
- Applying `z-index` to `position: static` elements (no effect)
- Using `position: fixed` for sticky headers and forgetting to add page padding for the content below
- Thinking sticky will work without a `top`/`bottom` offset set

---

## Quick practice
1. Create a card with a corner badge using `position: relative` on card and `position: absolute` on the badge
2. Build a fixed navigation bar that stays at the top while scrolling
3. Make a table header row `position: sticky; top: 0` inside a scrollable container
4. Create a centered modal overlay using `position: fixed` + `z-index` + `transform` centering
5. Test that `z-index` has no effect on a `position: static` element

---

## Official references
- MDN: position: https://developer.mozilla.org/en-US/docs/Web/CSS/position
- MDN: z-index: https://developer.mozilla.org/en-US/docs/Web/CSS/z-index
- MDN: Stacking context: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_positioned_layout/Understanding_z-index/Stacking_context
