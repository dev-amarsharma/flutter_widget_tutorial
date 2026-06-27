# Typography & Fonts

## Overview
Typography in CSS controls how text looks and reads. From choosing a font family to fine-tuning line spacing and alignment, these properties have a huge impact on readability and visual polish. Google Fonts makes it easy to load professional typefaces with a single HTML link.

---

## Why this topic matters
Good typography improves readability, establishes hierarchy, and reinforces brand identity. Poor typography makes content hard to read regardless of how good the design otherwise looks.

## font-family
```css
body {
  /* Provide fallbacks: browser picks the first available font */
  font-family: 'Segoe UI', Arial, sans-serif;
}

h1 {
  font-family: Georgia, 'Times New Roman', serif;
}

code {
  font-family: 'Courier New', Courier, monospace;
}
```

### Font stack rules
- Always end with a generic family: `serif`, `sans-serif`, `monospace`, `cursive`, `fantasy`
- Quote font names that contain spaces
- Fonts are tried left-to-right; the first available one is used

---

## font-size
```css
body   { font-size: 16px; }     /* absolute pixels */
h1     { font-size: 2rem; }     /* 2× root font size (32px if root = 16px) */
.small { font-size: 0.875em; }  /* relative to parent element's font size */
.pct   { font-size: 120%; }     /* 120% of inherited size */
```

**rem** (root em) is preferred for scalable, accessible sizing.

---

## font-weight
```css
p       { font-weight: 400; }   /* normal */
strong  { font-weight: 700; }   /* bold */
.light  { font-weight: 300; }   /* light (font must support it) */
```
Numeric values: 100 (thin) → 900 (black), in increments of 100. Keywords `normal` = 400, `bold` = 700.

---

## font-style and text-decoration
```css
em       { font-style: italic; }
.cite    { font-style: oblique; }
a        { text-decoration: underline; }
.no-link { text-decoration: none; }
del      { text-decoration: line-through; }
```

---

## line-height and letter-spacing
```css
p {
  line-height: 1.6;      /* unitless: 1.6× the font-size */
  letter-spacing: 0.02em; /* tiny space between characters */
}

h1 {
  line-height: 1.2;      /* tighter for headings */
  letter-spacing: -0.02em; /* slightly compressed for large text */
}
```

---

## text-align and text-transform
```css
.center  { text-align: center; }
.right   { text-align: right; }
.justify { text-align: justify; }

.caps    { text-transform: uppercase; }
.title   { text-transform: capitalize; } /* Capitalizes First Letter */
```

---

## Google Fonts
```html
<!-- In <head>, before your stylesheet -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet">
```
```css
body {
  font-family: 'Inter', sans-serif;
}
```

---

## Common mistakes to avoid
- Not providing a fallback generic font family
- Using `px` for font sizes everywhere (breaks user font-size preferences — prefer `rem`)
- Setting `line-height` with a unit like `px` (causes issues with font scaling)
- Using too many different font families on one page (two maximum is usually enough)

---

## Quick practice
1. Link the "Poppins" font from Google Fonts with weights 400 and 600
2. Apply it to `body` with a fallback of `sans-serif`
3. Style `h1`–`h3` with decreasing `font-size` values using `rem` units
4. Set `line-height: 1.6` on the body for comfortable reading
5. Verify by checking in the browser that the Google Font loaded in DevTools Network tab

---

## Official references
- MDN: font-family: https://developer.mozilla.org/en-US/docs/Web/CSS/font-family
- MDN: font-size: https://developer.mozilla.org/en-US/docs/Web/CSS/font-size
- Google Fonts: https://developer.mozilla.org/en-US/docs/Learn/CSS/Styling_text/Web_fonts
