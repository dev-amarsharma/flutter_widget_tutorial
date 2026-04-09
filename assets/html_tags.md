# HTML Tags and Structure

## Overview
HTML uses tags to define page elements and structure.
Most elements have an opening tag, content, and a closing tag, although some self-closing elements like `<img>` and `<input>` do not.

```html
<p>This is a paragraph.</p>
```

## Why this topic matters
Tags are the building blocks of every web page.
Using the right tags keeps code readable, accessible, and semantically meaningful.

---

## Common HTML tags
- `<h1>` to `<h6>` — headings.
- `<p>` — paragraphs.
- `<a>` — hyperlinks.
- `<img>` — images.
- `<ul>`, `<ol>`, `<li>` — lists.
- `<div>` — generic container.
- Semantic layout: `<section>`, `<article>`, `<header>`, `<main>`, `<aside>`, `<footer>`.

---

## Semantic HTML
Use tags that describe meaning, not just appearance.
Semantic HTML improves accessibility, search engine understanding, and maintainability.

```html
<main>
  <article>
    <h1>Learning HTML</h1>
    <p>Semantic structure improves readability.</p>
  </article>
</main>
```

---

## Nested structure
HTML elements are often nested inside one another.
Keep nesting logical and avoid improper order.

```html
<section>
  <h2>Topics</h2>
  <ul>
    <li>HTML</li>
    <li>CSS</li>
    <li>JavaScript</li>
  </ul>
</section>
```

Good indentation makes nested structure easier to read.

---

## Attributes and element details
Tags can include attributes to provide extra information.

```html
<a href="https://developer.mozilla.org/">MDN</a>
<img src="logo.png" alt="App logo" width="120" height="80">
```

- `href` — destination for links.
- `src` — image source URL.
- `alt` — image alternative text.
- `id` and `class` — identifiers for styling and scripting.

---

## Block-level vs inline elements
- Block-level elements like `<div>`, `<p>`, and `<section>` create new blocks on the page.
- Inline elements like `<span>`, `<strong>`, and `<a>` stay inside the current text flow.

Example:
```html
<p>This is a <strong>bold</strong> word in a paragraph.</p>
```

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tags and structure</title>
  </head>
  <body>
    <header>
      <h1>Introduction to tags</h1>
    </header>
    <main>
      <section>
        <h2>Why tags matter</h2>
        <p>HTML tags define the meaning and structure of page content.</p>
        <p>Use semantic tags whenever possible for clean markup.</p>
      </section>
    </main>
    <footer>
      <p>Page created in 2026.</p>
    </footer>
  </body>
</html>
```

---

## Common mistakes to avoid
- Overusing `<div>` instead of semantic tags.
- Omitting closing tags where required.
- Nesting block elements inside inline elements incorrectly.
- Using a heading only for styling.
- Using `<a>` without a meaningful `href`.

---

## Quick practice
1. Create a simple page with headings, paragraphs, and a link.
2. Use semantic layout tags like `<header>`, `<main>`, and `<footer>`.
3. Add an image with `alt` text.
4. Verify the markup is properly nested and indented.

---

## Official references
- MDN: HTML element reference: https://developer.mozilla.org/en-US/docs/Web/HTML/Element
- MDN: HTML semantics: https://developer.mozilla.org/en-US/docs/Glossary/Semantics
