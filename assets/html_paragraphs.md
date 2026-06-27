# HTML Paragraphs

## Overview
The `<p>` element defines a paragraph of text.
It groups related sentences into a readable block and provides semantic meaning for browsers and assistive technologies.

## Why this topic matters
Paragraphs are the most common way to structure body text on the web.
Good paragraph markup improves readability and keeps content accessible.

---

## Paragraph basics
```html
<p>This is a paragraph of text. It wraps sentences that belong together.</p>
```

### When to use `<p>`
- For regular body text.
- Inside articles, blog posts, descriptions, and content blocks.
- As a container for short inline elements like links, emphasis, and small formatting.

---

## Inserting other elements
Paragraphs can contain inline elements such as `<a>`, `<strong>`, and `<em>`.
Block-level elements should not be placed inside `<p>`.

```html
<p>
  Read the <a href="https://developer.mozilla.org">MDN Web Docs</a> for HTML guidance.
</p>
```

---

## Accessibility and semantics
Paragraphs help screen readers present text as coherent blocks.
Use paragraphs for actual text content rather than for spacing or layout.

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Paragraph example</title>
  </head>
  <body>
    <h1>About our product</h1>
    <p>Our product helps teams collaborate more efficiently by combining documents, chat, and tasks in one place.</p>
    <p>It is built with simplicity in mind and works across desktop and mobile devices.</p>
  </body>
</html>
```

---

## Common mistakes to avoid
- Using `<p>` for non-text layout elements like `<div>`-style spacing.
- Nesting block elements such as `<div>` or `<section>` inside `<p>`.
- Adding paragraph tags around individual words for styling.
- Leaving content outside of any paragraph when it should be grouped.

---

## Quick practice
1. Write two paragraphs describing your favorite feature.
2. Include a link and emphasized text inside one paragraph.
3. Check that paragraphs are separate content blocks in the rendered page.
4. Avoid using `<p>` for headings or lists.

---

## Official references
- MDN: `<p>` element: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/p
- MDN: HTML text fundamentals: https://developer.mozilla.org/en-US/docs/Learn/HTML/Introduction_to_HTML/HTML_text_fundamentals
