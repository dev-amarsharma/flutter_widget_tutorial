# Responsive HTML

## Overview
Responsive HTML helps web pages adapt to different screen sizes and devices.
A responsive page uses the viewport meta tag, flexible layouts, and media queries to look good on mobile, tablet, and desktop.

## Why this topic matters
Most users browse on mobile devices.
Responsive design ensures content is readable, interactive, and usable across screen sizes.

---

## Key techniques
- Add `<meta name="viewport" content="width=device-width, initial-scale=1.0">`.
- Use fluid widths like percentages instead of fixed pixels.
- Use responsive images with `srcset` and `sizes`.
- Apply CSS media queries to adapt layouts.
- Use semantic HTML and responsive CSS together.

---

## Viewport setup
Include this in the document head:

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

This tells browsers to scale the page to device width.

---

## Responsive layout example
```html
<style>
  .container {
    max-width: 900px;
    margin: 0 auto;
    padding: 1rem;
  }

  .card {
    border: 1px solid #ccc;
    padding: 1rem;
    margin-bottom: 1rem;
  }

  @media (min-width: 600px) {
    .grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 1rem;
    }
  }
</style>

<div class="container">
  <div class="grid">
    <div class="card">Card 1</div>
    <div class="card">Card 2</div>
  </div>
</div>
```

---

## Responsive images
Use `srcset` with different image sizes.

```html
<img
  src="photo-400.jpg"
  srcset="photo-400.jpg 400w, photo-800.jpg 800w, photo-1200.jpg 1200w"
  sizes="(max-width: 600px) 100vw, 600px"
  alt="Responsive image example"
>
```

---

## Accessibility and performance
1. Start with mobile-first CSS and add styles for larger screens.
2. Use responsive images to reduce download size on small devices.
3. Avoid fixed-width containers that require horizontal scrolling.
4. Keep touch targets large enough for mobile users.
5. Test on real devices or browser device emulation.

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive design example</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
      }

      .page {
        padding: 1rem;
      }

      .hero {
        background: #f7f7f7;
        padding: 1rem;
        margin-bottom: 1rem;
      }

      .grid {
        display: grid;
        gap: 1rem;
      }

      @media (min-width: 700px) {
        .grid {
          grid-template-columns: 1fr 1fr;
        }
      }
    </style>
  </head>
  <body>
    <div class="page">
      <section class="hero">
        <h1>Responsive HTML</h1>
        <p>Learn how to build pages that work on any screen.</p>
      </section>

      <div class="grid">
        <article class="card">
          <h2>Flexible layout</h2>
          <p>Use percentages and CSS grid to adapt content to different widths.</p>
        </article>
        <article class="card">
          <h2>Responsive images</h2>
          <p>Use `srcset` and `sizes` to load appropriate image sizes.</p>
        </article>
      </div>
    </div>
  </body>
</html>
```

---

## Common mistakes to avoid
- Omitting the viewport meta tag.
- Using fixed widths that cause horizontal scrolling.
- Relying on desktop-only design patterns.
- Ignoring touch target size and spacing.
- Loading large images on small screens.

---

## Quick practice
1. Add the viewport meta tag to a page.
2. Create a fluid container with a max-width.
3. Use a media query to change layout on wider screens.
4. Add responsive `srcset` images for a photo.

---

## Official references
- MDN: Responsive design: https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Responsive_Design
- MDN: Viewport meta tag: https://developer.mozilla.org/en-US/docs/Mozilla/Mobile/Viewport_meta_tag
