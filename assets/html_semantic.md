# Semantic HTML

## Overview
Semantic HTML uses elements whose names describe their meaning or role, such as `<header>`, `<main>`, `<article>`, and `<nav>`.
This makes markup easier to understand and helps browsers and assistive technologies process content correctly.

## Why this topic matters
Semantic structure improves accessibility, SEO, and developer clarity.
Using meaningful tags instead of generic wrappers makes your pages more robust and easier to maintain.

---

## Common semantic elements
- `<header>` — introductory content or navigation.
- `<nav>` — site or section navigation links.
- `<main>` — primary page content.
- `<article>` — independent content item, like a blog post.
- `<section>` — thematic grouping of content.
- `<aside>` — tangential content such as sidebars.
- `<footer>` — closing content or page metadata.

---

## Semantic structure example
```html
<body>
  <header>
    <h1>My blog</h1>
    <nav>
      <a href="#home">Home</a>
      <a href="#articles">Articles</a>
    </nav>
  </header>

  <main>
    <article>
      <h2>Semantic HTML</h2>
      <p>Use meaningful tags to improve structure.</p>
    </article>

    <aside>
      <h3>Related links</h3>
      <ul>
        <li><a href="#">Learn more</a></li>
      </ul>
    </aside>
  </main>

  <footer>
    <p>Copyright 2026</p>
  </footer>
</body>
```

---

## Accessibility and semantics
Semantic elements create landmarks that screen readers can use to navigate.
A clear outline helps users jump to the main content, navigation, or page sections.

---

## When to use semantic tags
1. Use `<article>` for content that could stand alone.
2. Use `<section>` for grouped content with a heading.
3. Use `<aside>` for related but non-essential information.
4. Use `<nav>` only for major navigation blocks.
5. Wrap the main content in `<main>` once per page.

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Semantic HTML example</title>
  </head>
  <body>
    <header>
      <h1>News site</h1>
      <nav>
        <a href="#top-stories">Top stories</a>
        <a href="#tech">Technology</a>
      </nav>
    </header>

    <main>
      <article>
        <h2>Semantic tags explained</h2>
        <p>Semantic HTML tells browsers what each part of the page represents.</p>
      </article>

      <section>
        <h2>More reading</h2>
        <p>Learn how semantics improves accessibility and SEO.</p>
      </section>
    </main>

    <aside>
      <h3>Did you know?</h3>
      <p>Search engines use semantic structure to better understand page content.</p>
    </aside>

    <footer>
      <p>Published April 2026</p>
    </footer>
  </body>
</html>
```

---

## Common mistakes to avoid
- Using `<div>` instead of semantic tags for meaningful sections.
- Using `<section>` without a heading.
- Placing multiple unrelated items inside one semantic wrapper.
- Not using `<main>` or using it more than once.
- Using `<aside>` for primary content.

---

## Quick practice
1. Convert a generic layout with `<div>` to semantic elements.
2. Add `<header>`, `<main>`, `<article>`, and `<footer>`.
3. Use `<nav>` for the main navigation block.
4. Confirm the page outline in browser accessibility tools.

---

## Official references
- MDN: Semantics in HTML: https://developer.mozilla.org/en-US/docs/Glossary/Semantics
- MDN: HTML sectioning elements: https://developer.mozilla.org/en-US/docs/Web/HTML/Element#sectioning_content
