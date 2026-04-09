# HTML Links

## Overview
The `<a>` element creates hyperlinks that connect to other pages, files, email addresses, or locations within the same page.
Use descriptive link text instead of generic labels like "click here".

## Why this topic matters
Links are the web’s primary navigation mechanism.
Well-written links improve usability, accessibility, and search engine understanding.

## Core concepts
- `href` holds the destination URL or resource.
- Text inside the `<a>` element should clearly describe the link target.
- Use `target="_blank"` for new tabs and `rel="noopener noreferrer"` for security.
- Anchor links (`#section`) jump to page fragments.
- `mailto:` and `tel:` create email and phone links.

---

## Basic link examples
```html
<a href="https://example.com">Visit example.com</a>
<a href="#section-2">Jump to section 2</a>
<a href="mailto:hello@example.com">Email support</a>
```

### Useful anchor attributes
- `href` — required destination.
- `target` — `_blank`, `_self`, `_parent`, `_top`.
- `rel` — recommended when using `_blank`.
- `download` — suggests file download.
- `title` — adds extra context for screen readers and tooltips.

---

## Accessibility and best practices
1. Write link text that makes sense out of context.
2. Avoid duplicate link text for different destinations.
3. Use `rel="noopener noreferrer"` with `target="_blank"` for security.
4. Prefer text links over clickable images unless the image has an accessible name.
5. Use anchor links for navigation within long pages.

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Link examples</title>
  </head>
  <body>
    <h1>Useful links</h1>

    <p>
      Read the <a href="https://developer.mozilla.org">MDN Web Docs</a> for tutorials and references.
    </p>

    <p>
      Jump to the <a href="#details">details section</a> below.
    </p>

    <section id="details">
      <h2>Details</h2>
      <p>
        Download the sample file: <a href="sample.pdf" download>Download PDF</a>.
      </p>
    </section>
  </body>
</html>
```

---

## Common mistakes to avoid
- Using link text like "click here" or "learn more" without context.
- Forgetting `rel="noopener noreferrer"` on external links opened in a new tab.
- Adding links to non-link text or using links purely for styling.
- Omitting `href` and using `<a>` as a button.
- Relying on images as the only link without an `alt` description.

---

## Quick practice
1. Add three links: external, internal anchor, and `mailto:`.
2. Use descriptive text that explains the destination.
3. Set `target="_blank"` and `rel="noopener noreferrer"` for external links.
4. Test the links in a browser and verify they behave as expected.

---

## Official references
- MDN: `<a>` element: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a
- MDN: Using the `download` attribute: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a#attr-download
