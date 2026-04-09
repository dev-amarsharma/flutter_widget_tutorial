# iFrame

## Overview
The `<iframe>` element embeds another HTML document inside the current page.
It is commonly used for embedding maps, videos, widgets, and external content.

## Why this topic matters
Using iframes safely is important for performance, security, and accessibility.
A well-configured iframe prevents clickjacking, respects sandboxing, and remains usable for all visitors.

## Core concepts
- `src` specifies the URL to display inside the iframe.
- `title` provides an accessible name for screen readers.
- `sandbox` restricts what the embedded content can do.
- `loading="lazy"` defers loading until the iframe is near viewport.
- `allow` enables specific features like `fullscreen` or `camera`.

---

## Basic iframe syntax
```html
<iframe
  src="https://example.com"
  title="Example site content"
  width="600"
  height="400"
  loading="lazy"
  sandbox="allow-scripts allow-same-origin"
></iframe>
```

### Important iframe attributes
- `title` — required for accessibility.
- `sandbox` — limits scripts, forms, popups, and navigation.
- `allowfullscreen` — permits full-screen mode.
- `referrerpolicy` — controls the Referer header.
- `loading` — `lazy` or `eager` to control loading behavior.

---

## Security and sandboxing
Always add `sandbox` when embedding untrusted content.
A strict sandbox can be relaxed using specific permissions.

```html
<iframe
  src="https://trusted.example.com"
  title="Embedded map"
  sandbox="allow-scripts allow-same-origin"
></iframe>
```

---

## Accessibility and fallback content
Include `title` for screen readers and optional fallback text for browsers that do not support iframes.

```html
<iframe src="https://example.com" title="Embedded article">
  Your browser does not support inline frames. Visit <a href="https://example.com">this page</a> instead.
</iframe>
```

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Embedded map example</title>
  </head>
  <body>
    <h1>Our office location</h1>

    <iframe
      src="https://www.google.com/maps/embed?pb=!1m18..."
      title="Location map"
      width="600"
      height="450"
      loading="lazy"
      allowfullscreen
      sandbox="allow-scripts allow-same-origin"
    ></iframe>
    <p>
      If the map does not load, use the link to open it in a new tab.
    </p>
  </body>
</html>
```

---

## Common mistakes to avoid
- Omitting the `title` attribute.
- Embedding untrusted content without `sandbox`.
- Using iframes for core content that should be part of the page.
- Not providing fallback content or a meaningful link.
- Forgetting lazy loading for large or off-screen iframes.

---

## Quick practice
1. Add an iframe with `src`, `title`, and `loading="lazy"`.
2. Include `sandbox` for embedded content.
3. Provide fallback text with a link to the source page.
4. Keep iframe content supplemental, not critical.

---

## Official references
- MDN: `<iframe>` element: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe
- MDN: Using the `sandbox` attribute: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe#attr-sandbox
