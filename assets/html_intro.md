# HTML Introduction

## Overview
HTML (HyperText Markup Language) describes the structure and content of a web page.
It uses elements and attributes to create headings, paragraphs, links, images, forms, and other page sections.

HTML is responsible for structure; CSS handles presentation, and JavaScript handles behavior.

---

## Why this topic matters
HTML is the foundation of web development.
A strong understanding of HTML makes it easier to build accessible, maintainable, and search-friendly web pages.

## Core document structure
```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My First Page</title>
  </head>
  <body>
    <h1>Hello, Web</h1>
    <p>This is my first HTML page.</p>
  </body>
</html>
```

### Key parts
- `<!DOCTYPE html>` tells the browser to use HTML5.
- `<html>` wraps the entire document.
- `<head>` holds metadata, title, and links to styles or scripts.
- `<body>` contains the visible content.

---

## What HTML can describe
HTML organizes content into meaningful elements such as:
- headings (`<h1>`–`<h6>`),
- paragraphs (`<p>`),
- links (`<a>`),
- images (`<img>`),
- lists (`<ul>`, `<ol>`, `<li>`),
- forms (`<form>`, `<input>`, `<button>`),
- sections (`<section>`, `<article>`, `<nav>`).

---

## Semantic HTML
Use semantic tags to give meaning to content.
Semantic HTML improves accessibility and helps tools like search engines understand your page.

Example:
```html
<header>
  <h1>Welcome</h1>
</header>
<main>
  <article>
    <h2>About this page</h2>
    <p>This is a simple HTML introduction.</p>
  </article>
</main>
<footer>
  <p>Copyright 2026</p>
</footer>
```

---

## Common mistakes to avoid
- Leaving out `<!DOCTYPE html>`.
- Putting visible content inside `<head>`.
- Using tags purely for styling instead of structure.
- Skipping heading levels or using headings only to change text size.
- Forgetting `lang="en"` on the `<html>` element.

---

## Quick practice
1. Build a simple page with a title, heading, paragraph, link, and image.
2. Add `lang="en"` and meta viewport tags.
3. Use semantic sections like `<header>`, `<main>`, and `<footer>`.
4. View the page source and identify each HTML element.

---

## Official references
- MDN: HTML introduction: https://developer.mozilla.org/en-US/docs/Web/HTML
- MDN: HTML basics: https://developer.mozilla.org/en-US/docs/Learn/HTML/Introduction_to_HTML
