# Specificity & Cascade

## Overview
When multiple CSS rules target the same element and set the same property, the browser must decide which value wins. This decision is driven by the cascade — a defined algorithm that weighs rule origin, specificity, and source order. Understanding the cascade is the key to writing predictable, maintainable CSS.

---

## Why this topic matters
Specificity bugs are among the most common CSS frustrations. Developers add `!important` everywhere trying to override styles, then wonder why nothing works. Understanding the cascade lets you write intentional, conflict-free CSS.

## The cascade algorithm
The browser resolves conflicts in this priority order (highest wins):
1. **Origin and importance** — browser user-agent styles < author styles < author `!important` < user `!important`
2. **Specificity** — more specific selectors override less specific ones
3. **Source order** — if everything else ties, the last rule wins

---

## Specificity calculation
Specificity is a score represented as three numbers: **(A, B, C)**

| Selector type | Column |
|---|---|
| ID selectors (`#id`) | A |
| Class, attribute, pseudo-class (`.class`, `[attr]`, `:hover`) | B |
| Element and pseudo-element (`div`, `::before`) | C |

```
Selector              | A | B | C | Total score
-----------------------------|---|---|---|------------
p                     | 0 | 0 | 1 | (0,0,1)
.intro                | 0 | 1 | 0 | (0,1,0)
p.intro               | 0 | 1 | 1 | (0,1,1)
#hero                 | 1 | 0 | 0 | (1,0,0)
#hero .btn            | 1 | 1 | 0 | (1,1,0)
div#hero .btn:hover   | 1 | 2 | 1 | (1,2,1)
```

Higher A > higher B > higher C. Inline styles are `(1,0,0,0)` — above all.

```css
p { color: gray; }            /* (0,0,1) */
.text { color: blue; }        /* (0,1,0) — wins over p alone */
p.text { color: green; }      /* (0,1,1) — wins over .text alone */
#hero p.text { color: red; }  /* (1,1,1) — wins over all above */
```

---

## !important
```css
p { color: blue !important; } /* overrides everything except user !important */
```

`!important` breaks the natural cascade. Use only as a last resort:
- Utility classes where you always want to override (e.g., `.hidden { display: none !important; }`)
- Overriding third-party styles you can't control

Never use `!important` to fight your own styles — that's a signal to fix your specificity architecture.

---

## Inheritance
Some properties are inherited by default (text-related: `color`, `font-*`, `line-height`). Others are not (layout-related: `margin`, `padding`, `border`, `display`).

```css
body { color: #333; font-family: sans-serif; } /* inherited by all children */

.card { margin: 16px; } /* NOT inherited */
```

You can force or prevent inheritance:
```css
.item { color: inherit; }  /* inherit from parent even if not normally inherited */
.item { color: initial; }  /* reset to browser default */
.item { color: unset; }    /* inherit if inheritable, else initial */
```

---

## Specificity strategies
```css
/* Layer your styles from low to high specificity */
/* Base/reset — element selectors */
p { margin: 0; }

/* Components — class selectors */
.card-body { padding: 16px; }

/* Modifiers — still class-based */
.card-body.compact { padding: 8px; }

/* State — class or attribute */
.card-body:focus-within { outline: 2px solid blue; }

/* Avoid: escalating to IDs just to override classes */
/* Avoid: chaining more than 3 selectors */
```

---

## Common mistakes to avoid
- Sprinkling `!important` throughout a stylesheet instead of fixing specificity
- Using IDs for styling (high specificity; hard to override)
- Not understanding that specificity is not about rule order — a later rule with lower specificity still loses
- Assuming inheritance means all properties pass down (only inheritable properties do)

---

## Quick practice
1. Write three rules targeting the same `<p>` with different specificities and predict which color wins
2. Add `!important` to the lowest-specificity rule and verify it now wins
3. Create a base `color` on `body` and verify a child inherits it without an explicit rule
4. Use `color: inherit` on a button to force it to pick up the parent text color
5. Use browser DevTools to see the "Styles" panel strikethrough, which shows overridden rules

---

## Official references
- MDN: Specificity: https://developer.mozilla.org/en-US/docs/Web/CSS/Specificity
- MDN: Cascade and inheritance: https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Cascade_and_inheritance
