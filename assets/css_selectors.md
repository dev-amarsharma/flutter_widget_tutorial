# CSS Selectors

## Overview
CSS selectors determine which HTML elements a style rule targets. From simple element names to complex attribute patterns, selectors give you precise control over what gets styled. Understanding selectors — and how they combine — is the foundation of writing maintainable CSS.

---

## Why this topic matters
Poorly chosen selectors lead to style conflicts, unexpected overrides, and bloated stylesheets. Mastering selectors lets you apply styles confidently without unintended side effects.

## Basic selectors
```css
/* Element selector — targets all <p> tags */
p { color: #333; }

/* Class selector — targets elements with class="highlight" */
.highlight { background: yellow; }

/* ID selector — targets the element with id="main-header" */
#main-header { font-size: 32px; }

/* Universal selector — targets everything */
* { box-sizing: border-box; }
```

### Key parts
- **Element** (`p`, `h1`, `div`) — matches tag name; broad impact
- **Class** (`.name`) — reusable; apply to many elements
- **ID** (`#name`) — unique per page; highest non-inline specificity
- **Universal** (`*`) — use sparingly; catches everything

---

## Attribute selectors
```css
/* Elements with a specific attribute present */
input[required] { border-color: red; }

/* Attribute equals a value */
a[target="_blank"] { color: orange; }

/* Attribute contains a substring */
img[src*="logo"] { width: 120px; }
```

---

## Combinator selectors
```css
/* Descendant — any <span> inside a <div> */
div span { font-style: italic; }

/* Child — only direct <li> children of <ul> */
ul > li { list-style: square; }

/* Adjacent sibling — <p> immediately after <h2> */
h2 + p { font-weight: bold; }

/* General sibling — all <p> siblings after <h2> */
h2 ~ p { color: gray; }
```

### Key parts
- **Space** — descendant (any depth)
- `>` — direct child only
- `+` — immediately following sibling
- `~` — all following siblings

---

## Specificity introduction
When multiple rules target the same element, specificity decides which wins. Each selector type has a score:

| Selector type | Score |
|---|---|
| Inline style | 1-0-0-0 |
| ID (`#id`) | 0-1-0-0 |
| Class / attribute / pseudo-class | 0-0-1-0 |
| Element / pseudo-element | 0-0-0-1 |

Higher score wins. If equal, the last rule in source order wins.

```css
p { color: black; }          /* specificity: 0-0-0-1 */
.intro { color: blue; }      /* specificity: 0-0-1-0 — wins */
#hero { color: red; }        /* specificity: 0-1-0-0 — wins if both match */
```

---

## Common mistakes to avoid
- Overusing ID selectors (hard to override later)
- Chaining too many selectors in one rule (fragile and slow)
- Forgetting that class names are case-sensitive
- Using universal selector `*` with expensive properties in large pages

---

## Quick practice
1. Add three `<p>` tags: give two the class `"intro"` and one the id `"featured"`
2. Style `.intro` with `color: steelblue` and `#featured` with `color: crimson`
3. Add a rule that targets `a[href^="https"]` to make external links green
4. Use `ul > li` to add a custom `list-style-type` only to direct list items
5. Open in the browser and verify each rule applies as expected

---

## Official references
- MDN: CSS Selectors: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_selectors
- MDN: Specificity: https://developer.mozilla.org/en-US/docs/Web/CSS/Specificity
