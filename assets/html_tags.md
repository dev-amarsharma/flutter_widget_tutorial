# HTML Tags and Structure

## Overview
HTML uses tags to define elements on the page. Most elements have:

- an opening tag,
- content,
- and a closing tag.

Example:

```html
<p>This is a paragraph.</p>
```

## Common structural tags

- `<h1>` to `<h6>` for headings
- `<p>` for paragraphs
- `<a>` for links
- `<img>` for images
- `<ul>` and `<ol>` for lists
- `<div>` for generic grouping
- `<section>`, `<article>`, `<header>`, `<main>`, and `<footer>` for semantic layout

## Semantic HTML
Semantic tags describe meaning, not just appearance.

Example:

```html
<main>
  <article>
    <h1>Learning HTML</h1>
    <p>Semantic structure improves readability.</p>
  </article>
</main>
```

Benefits:

- better accessibility,
- clearer code,
- easier maintenance,
- improved search engine understanding.

## Nested elements
HTML elements are often nested:

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

Indentation is not required by browsers, but it makes code easier to read.

## Attributes
Tags can include attributes:

```html
<a href="https://developer.mozilla.org/">MDN</a>
<img src="logo.png" alt="App logo" />
```

- `href` points to a link destination.
- `src` points to an image source.
- `alt` describes the image for accessibility and fallback behavior.

## Best practices

- Prefer semantic tags when they match the content.
- Keep nesting simple and readable.
- Always include useful `alt` text for meaningful images.
- Close tags correctly.

## Common mistakes

- Using too many generic `<div>` elements.
- Skipping `alt` text for important images.
- Breaking nesting order.
- Using multiple `<h1>` tags without clear structure.

## References
- MDN HTML elements reference: https://developer.mozilla.org/en-US/docs/Web/HTML/Element
