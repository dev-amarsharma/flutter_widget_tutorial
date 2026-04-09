# HTML Best Practices

## Overview
Good HTML best practices combine semantic markup, accessibility, performance, and maintainability.
Following them makes content easier to read, faster to load, and more reliable across browsers.

## Why this topic matters
HTML is the foundation of every web page.
Best practices help you build pages that are accessible, searchable, and easier to maintain.

---

## Key best practices
- Use semantic HTML tags, not just `<div>` and `<span>`.
- Add accessible text, such as `alt` for images and `title` where needed.
- Keep structure logical with headings and sections.
- Avoid inline styling and prefer CSS for presentation.
- Use responsive design patterns like `meta viewport` and flexible layouts.

---

## Maintainability tips
- Keep HTML clean and well-indented.
- Use meaningful `id` and `class` names.
- Group related content with semantic containers.
- Avoid repetitive code by reusing components or templates.

---

## Accessibility guidance
- Ensure every image has an appropriate `alt` attribute.
- Use `label` elements for form inputs.
- Provide captions or transcripts for audio/video content.
- Use landmarks like `<main>`, `<nav>`, `<header>`, and `<footer>`.

---

## Performance considerations
- Use responsive images with `srcset`.
- Lazy-load off-screen images and iframes.
- Minimize unnecessary markup.
- Prefer modern HTML features over legacy hacks.

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HTML Best Practices</title>
  </head>
  <body>
    <header>
      <h1>HTML Best Practices</h1>
      <nav>
        <a href="#semantic">Semantic HTML</a>
        <a href="#accessibility">Accessibility</a>
      </nav>
    </header>

    <main>
      <section id="semantic">
        <h2>Use semantic tags</h2>
        <p>Semantic HTML improves structure and accessibility.</p>
      </section>

      <section id="accessibility">
        <h2>Add accessible attributes</h2>
        <p>Always use clear labels and alternative text where needed.</p>
      </section>
    </main>

    <footer>
      <p>Built with HTML best practices in mind.</p>
    </footer>
  </body>
</html>
```

---

## Common mistakes to avoid
- Using HTML for layout rather than structure.
- Omitting `alt` text or labels.
- Mixing markup and styling.
- Building pages that are not responsive.
- Writing messy, deeply nested HTML.

---

## Quick practice
1. Convert a page with generic tags into semantic HTML.
2. Add accessible attributes to images and forms.
3. Remove inline styles from HTML and use CSS instead.
4. Check the page in browser dev tools for structure and accessibility.

---

## Official references
- MDN: HTML best practices: https://developer.mozilla.org/en-US/docs/Learn/HTML
- web.dev: Learn HTML: https://web.dev/learn/html/
