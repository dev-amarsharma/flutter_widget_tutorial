# HTML Semantic Layout

## Overview
Semantic layout uses meaningful HTML elements to define the structure of a page.
Instead of generic `<div>` wrappers, semantic tags describe the role of each section.

## Why this topic matters
Semantic layout improves accessibility, readability, and search engine understanding.
It also makes code easier to maintain and helps browsers identify page landmarks.

---

## Common semantic layout elements
- `<header>` — page or section header.
- `<nav>` — navigation links.
- `<main>` — main page content.
- `<section>` — grouped content with a heading.
- `<article>` — independent content item.
- `<aside>` — sidebar or supplemental content.
- `<footer>` — page or section footer.

---

## Semantic layout example
```html
<header>
  <h1>Learning Web Basics</h1>
  <nav>
    <a href="#html">HTML</a>
    <a href="#css">CSS</a>
    <a href="#js">JavaScript</a>
  </nav>
</header>

<main>
  <section id="html">
    <h2>HTML</h2>
    <p>Structure your page clearly with meaningful tags.</p>
  </section>

  <aside>
    <h3>Tip</h3>
    <p>Use semantic HTML before adding styling.</p>
  </aside>
</main>

<footer>
  <p>Copyright 2026</p>
</footer>
```

---

## When to use each element
1. Use `<header>` for page or section headers and introductory content.
2. Use `<nav>` for primary navigation menus.
3. Use `<main>` once for the page’s primary content.
4. Use `<section>` for content grouped by topic.
5. Use `<article>` for content that can be reused or syndicated.
6. Use `<aside>` for related or tangential content.
7. Use `<footer>` for copyright, author info, or related links.

---

## Accessibility and semantics
Clear semantic layout creates landmarks that screen readers and other assistive technologies can navigate.
A consistent structure helps users find the main content and understand page organization.

---

## Common mistakes to avoid
- Using semantic tags only for styling purposes.
- Using multiple `<main>` elements.
- Placing unrelated content inside a single `<section>`.
- Using `<div>` instead of an appropriate semantic element.
- Leaving out headings for sections.

---

## Quick practice
1. Build a page using `<header>`, `<main>`, and `<footer>`.
2. Add a `<nav>` menu and a `<section>` with a heading.
3. Place supplemental content in an `<aside>`.
4. Review the page structure in browser accessibility tools.

---

## Official references
- MDN: Structuring documents: https://developer.mozilla.org/en-US/docs/Learn/HTML/Introduction_to_HTML/Document_and_website_structure
- MDN: HTML element reference: https://developer.mozilla.org/en-US/docs/Web/HTML/Element
