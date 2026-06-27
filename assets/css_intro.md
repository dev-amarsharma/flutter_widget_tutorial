# CSS Introduction

## Overview
CSS (Cascading Style Sheets) is the language used to style HTML documents. It controls how elements look on screen — colors, fonts, spacing, layout, and animations. Without CSS, every webpage would look like a plain text document.

---

## Why this topic matters
CSS transforms raw HTML into polished, visually appealing interfaces. Every professional website relies on CSS for branding, usability, and responsive behavior across devices.

## What is CSS?
CSS works by selecting HTML elements and applying visual rules to them. A CSS rule has two parts: a **selector** that targets elements, and a **declaration block** containing one or more property–value pairs.

```css
/* Selector: p (paragraph elements) */
p {
  color: navy;        /* property: value */
  font-size: 16px;
  margin-bottom: 12px;
}
```

### Key parts
- **Selector** — identifies which HTML elements to style
- **Declaration block** — the `{ }` that wraps all rules
- **Property** — the aspect to change (e.g., `color`, `font-size`)
- **Value** — what to set the property to (e.g., `navy`, `16px`)
- **Semicolon** — separates declarations inside a block

---

## How to include CSS in HTML
There are three ways to add CSS to a webpage:

### 1. External stylesheet (recommended)
```html
<head>
  <link rel="stylesheet" href="styles.css">
</head>
```
A separate `.css` file linked from `<head>`. Best for maintainability and reuse.

### 2. Internal `<style>` block
```html
<head>
  <style>
    h1 { color: crimson; }
  </style>
</head>
```
CSS written directly inside the HTML file. Useful for single-page demos.

### 3. Inline styles
```html
<p style="color: green; font-weight: bold;">Hello</p>
```
Applied directly on an element. Hardest to maintain; avoid for large projects.

---

## Cascade and Inheritance overview
CSS stands for *Cascading* Style Sheets. "Cascading" means multiple rules can apply to the same element, and CSS resolves conflicts by a priority order:

1. **Origin** — browser defaults < author stylesheets < inline styles
2. **Specificity** — more specific selectors win (covered in css_specificity)
3. **Order** — when everything else is equal, the last rule wins

**Inheritance** means some properties (like `color` and `font-family`) automatically pass down from parent to child elements, so you don't need to repeat them on every element.

```css
body {
  font-family: Arial, sans-serif; /* inherited by all children */
  color: #333;
}
```

---

## Common mistakes to avoid
- Forgetting the semicolons between declarations
- Using inline styles excessively (hard to override and maintain)
- Not linking the stylesheet correctly (wrong path or missing `rel="stylesheet"`)
- Expecting non-inherited properties like `border` to automatically apply to children

---

## Quick practice
1. Create an `index.html` with a heading, a paragraph, and a list
2. Create a `styles.css` file and link it in `<head>`
3. Set the `body` background to `#f5f5f5` and the `h1` color to `steelblue`
4. Add a `font-size` of `18px` to paragraphs
5. Open the file in a browser and confirm the styles apply

---

## Official references
- MDN: CSS Basics: https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/CSS_basics
- MDN: How CSS works: https://developer.mozilla.org/en-US/docs/Learn/CSS/First_steps/How_CSS_works
