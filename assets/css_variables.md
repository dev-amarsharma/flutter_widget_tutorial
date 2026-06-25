# CSS Variables

## Overview
CSS custom properties (commonly called CSS variables) let you store reusable values — colors, spacing, font sizes — in named tokens. Defined once, they can be used throughout your stylesheet, updated in one place, and even changed dynamically with JavaScript. They're the foundation of modern CSS theming.

---

## Why this topic matters
CSS variables eliminate repetition, make global changes trivial, and enable runtime theming (light/dark mode) without rewriting large amounts of CSS. They're native to the browser — no preprocessor required.

## Defining custom properties
```css
/* :root makes the variable globally available */
:root {
  --color-primary: #3498db;
  --color-secondary: #2ecc71;
  --spacing-sm: 8px;
  --spacing-md: 16px;
  --spacing-lg: 32px;
  --font-size-base: 16px;
  --border-radius: 4px;
}
```

Custom property names must start with `--`. They are case-sensitive.

---

## Using var()
```css
.button {
  background: var(--color-primary);
  padding: var(--spacing-sm) var(--spacing-md);
  border-radius: var(--border-radius);
  font-size: var(--font-size-base);
}

.card {
  margin-bottom: var(--spacing-lg);
  border: 1px solid var(--color-secondary);
}
```

---

## Fallback values
If a variable is not defined, `var()` accepts a fallback:
```css
.element {
  color: var(--color-text, #333);          /* use #333 if --color-text isn't set */
  background: var(--bg, var(--fallback, white)); /* chained fallbacks */
}
```

---

## Scoped variables
Variables can be scoped to any selector, not just `:root`:

```css
:root { --btn-bg: steelblue; }

.danger-zone {
  /* Override for elements inside .danger-zone */
  --btn-bg: crimson;
}

.button {
  background: var(--btn-bg); /* steelblue everywhere except .danger-zone */
}
```

---

## Theming with CSS variables
```css
:root {
  --bg: #ffffff;
  --text: #222222;
  --surface: #f0f0f0;
}

[data-theme="dark"] {
  --bg: #121212;
  --text: #eeeeee;
  --surface: #1e1e1e;
}

body {
  background: var(--bg);
  color: var(--text);
}
```

Switch theme with JavaScript:
```javascript
document.documentElement.setAttribute('data-theme', 'dark');
```

---

## Updating variables with JavaScript
```javascript
// Set a CSS variable
document.documentElement.style.setProperty('--color-primary', '#e74c3c');

// Read a CSS variable
const value = getComputedStyle(document.documentElement)
  .getPropertyValue('--color-primary').trim();
```

---

## Common mistakes to avoid
- Using single dash (`-name`) instead of double dash (`--name`) — invalid syntax
- Defining variables without `:root` when you need them globally
- Forgetting that CSS variables are inherited — a child scope can override them
- Trying to use CSS variables in media query conditions (not supported; use preprocessors for that)

---

## Quick practice
1. Define a `:root` with 3 color variables and 2 spacing variables
2. Apply them throughout a page's buttons, cards, and headings
3. Add a second attribute selector (`[data-theme="dark"]`) that overrides the colors
4. Toggle the theme class with a JavaScript button click
5. Use a fallback value in `var()` for a color that isn't defined yet

---

## Official references
- MDN: CSS custom properties: https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties
- MDN: var(): https://developer.mozilla.org/en-US/docs/Web/CSS/var
