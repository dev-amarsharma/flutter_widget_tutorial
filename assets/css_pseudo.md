# Pseudo-classes & Pseudo-elements

## Overview
Pseudo-classes target elements based on their state or position in the document (like `:hover` or `:nth-child`), while pseudo-elements create virtual elements you can style without adding HTML (like `::before` and `::after`). Together they unlock a huge range of styling patterns.

---

## Why this topic matters
Pseudo-classes and pseudo-elements let you build interactive states, decorative effects, and structural styles entirely in CSS — reducing the need for extra HTML markup and JavaScript event handlers.

## Common pseudo-classes

### User-action states
```css
a:hover  { color: orange; text-decoration: underline; }  /* mouse over */
a:focus  { outline: 2px solid blue; }                    /* keyboard focus */
a:active { color: red; }                                 /* being clicked */

input:focus         { border-color: steelblue; box-shadow: 0 0 0 3px rgba(70,130,180,0.3); }
input:disabled      { opacity: 0.5; cursor: not-allowed; }
input:checked       { accent-color: green; }
input:placeholder-shown { border-color: gray; }
```

### Structural pseudo-classes
```css
li:first-child  { font-weight: bold; }          /* first <li> in its parent */
li:last-child   { border-bottom: none; }         /* last <li> */
li:nth-child(2) { background: lightyellow; }     /* exactly the 2nd child */
li:nth-child(odd)  { background: #f9f9f9; }     /* odd rows */
li:nth-child(even) { background: #ffffff; }     /* even rows */
li:nth-child(3n)   { color: navy; }             /* every 3rd item */

p:only-child  { margin: 0; }  /* only child of its parent */
p:not(.skip)  { color: #333; } /* any <p> that doesn't have .skip */
```

---

## :is() and :where() (modern selectors)
```css
/* :is() — matches any of the listed selectors, keeps the highest specificity */
:is(h1, h2, h3) { margin-top: 1.5rem; }

/* :where() — same but specificity is always 0 */
:where(h1, h2, h3) { margin-top: 1.5rem; }
```

---

## Pseudo-elements
Pseudo-elements use `::` (double colon) and create virtual elements in the DOM.

### ::before and ::after
```css
.card::before {
  content: "NEW ";     /* required — can be empty string */
  color: crimson;
  font-weight: bold;
}

/* Decorative underline effect */
h2 {
  position: relative;
}
h2::after {
  content: '';
  position: absolute;
  left: 0;
  bottom: -4px;
  width: 100%;
  height: 3px;
  background: steelblue;
}
```

### Key parts of ::before / ::after
- **content** — required property; the pseudo-element only renders if `content` is set
- They are treated as children of the element, not siblings
- Can use `position: absolute` relative to the parent (if parent has `position: relative`)

---

## ::first-letter and ::first-line
```css
p::first-letter {
  font-size: 2.5em;
  float: left;
  line-height: 1;
  margin-right: 4px;
}

p::first-line {
  font-variant: small-caps;
}
```

---

## ::placeholder and ::selection
```css
input::placeholder { color: #aaa; font-style: italic; }

::selection {
  background: #3498db;
  color: white;
}
```

---

## Common mistakes to avoid
- Using a single colon for pseudo-elements (`:before` works but `::before` is the standard)
- Forgetting `content: ''` on `::before`/`::after` — they won't render without it
- Not adding `position: relative` to the parent when using absolutely-positioned pseudo-elements
- Overusing `:nth-child` without accounting for added/removed elements changing the pattern

---

## Quick practice
1. Add a hover effect to navigation links with a color change and transition
2. Add zebra-stripe table rows using `:nth-child(odd)` and `:nth-child(even)`
3. Create a decorative horizontal line under all `<h2>` elements using `::after`
4. Style a form's focused inputs with a blue glow using `:focus`
5. Highlight selected text in your brand color using `::selection`

---

## Official references
- MDN: Pseudo-classes: https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-classes
- MDN: Pseudo-elements: https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-elements
- MDN: ::before: https://developer.mozilla.org/en-US/docs/Web/CSS/::before
