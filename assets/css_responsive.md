# Responsive Design

## Overview
Responsive design ensures a website looks and works well on all screen sizes — from a 320px phone to a 4K monitor. It relies on a combination of flexible layouts, the viewport meta tag, and CSS media queries to adapt styles based on the device's characteristics.

---

## Why this topic matters
Over half of all web traffic comes from mobile devices. A site that only works on desktop is broken for the majority of your users. Responsive design is not optional — it's a baseline requirement.

## The viewport meta tag
Without this tag, mobile browsers render pages as if they were desktop-width and scale them down:

```html
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
```

- `width=device-width` — match the physical screen width
- `initial-scale=1.0` — no zoom applied on load

---

## Media queries
Media queries apply styles only when a condition is true.

```css
/* Applied when screen width is at most 768px */
@media (max-width: 768px) {
  .sidebar { display: none; }
  .main    { width: 100%; }
}

/* Applied when screen is at least 1024px */
@media (min-width: 1024px) {
  .container { max-width: 1200px; margin: 0 auto; }
}

/* Range — tablet range */
@media (min-width: 600px) and (max-width: 1023px) {
  .grid { grid-template-columns: repeat(2, 1fr); }
}
```

---

## Common breakpoints
```css
/* Mobile-first approach — base styles are for mobile */
/* Then add complexity as screen grows */

/* Small phones (default, no query needed) */
.grid { grid-template-columns: 1fr; }

/* Tablets */
@media (min-width: 600px) {
  .grid { grid-template-columns: repeat(2, 1fr); }
}

/* Desktops */
@media (min-width: 1024px) {
  .grid { grid-template-columns: repeat(3, 1fr); }
}

/* Large desktops */
@media (min-width: 1280px) {
  .grid { grid-template-columns: repeat(4, 1fr); }
}
```

---

## Mobile-first approach
Start with base styles for the smallest screen, then progressively enhance using `min-width` queries. This is the recommended approach because:
- Smaller devices load less CSS
- Forces you to prioritize content
- Easier to build up complexity than to strip it down

**Avoid desktop-first** (`max-width` heavy) unless working on legacy sites.

---

## Flexible units
```css
/* Use relative/flexible units instead of fixed pixels */
.container {
  max-width: 1200px;
  width: 90%;         /* 90% of the parent, works on any screen */
  margin: 0 auto;
}

.text { font-size: clamp(1rem, 2.5vw, 1.5rem); } /* fluid font size */

img { max-width: 100%; height: auto; } /* responsive images */
```

---

## Media feature queries beyond width
```css
/* Portrait vs landscape */
@media (orientation: portrait) { ... }

/* Dark mode preference */
@media (prefers-color-scheme: dark) {
  body { background: #111; color: #eee; }
}

/* Hover capability (touch vs mouse) */
@media (hover: none) {
  .tooltip { display: none; } /* no hover on touch devices */
}
```

---

## Common mistakes to avoid
- Forgetting the viewport meta tag (the single most common mobile bug)
- Using fixed pixel widths for containers instead of `%` or `max-width`
- Writing desktop-first CSS and trying to undo everything with `max-width` queries
- Not testing on real devices (DevTools emulation is not 100% accurate)

---

## Quick practice
1. Build a single-column layout with no media queries as your mobile base
2. Add a `@media (min-width: 768px)` query that switches to a two-column layout
3. Add a `@media (min-width: 1024px)` query for a three-column layout
4. Use DevTools device toolbar to test at 375px, 768px, and 1280px widths
5. Add a dark mode media query that swaps the background and text colors

---

## Official references
- MDN: Responsive Design: https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Responsive_Design
- MDN: media queries: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_media_queries/Using_media_queries
