# SEO Basics

## Overview
SEO (Search Engine Optimization) helps web pages become easier to find and understand by search engines.
Good SEO starts with strong HTML structure, descriptive metadata, and meaningful content.

## Why this topic matters
SEO increases visibility, drives traffic, and helps users discover your content.
A well-structured page also improves accessibility and user experience.

---

## Core SEO HTML elements
- `<title>` — page title shown in search results.
- `<meta name="description">` — short page summary for search engines.
- `<h1>` and headings — organize page content.
- `<a>` — descriptive links build context.
- Semantic tags — help search engines understand page structure.

---

## Title and meta description
```html
<head>
  <title>Beginner HTML SEO guide</title>
  <meta name="description" content="Learn SEO-friendly HTML practices for headings, links, and metadata.">
</head>
```

### Best practices
- Keep titles concise and descriptive.
- Use unique titles per page.
- Write a clear description that summarizes the page.
- Avoid keyword stuffing.

---

## Headings and content structure
Use one `<h1>` for the main topic and nested headings for sections.

```html
<h1>HTML SEO tips</h1>
<h2>Use semantic structure</h2>
<p>Meaningful HTML helps search engines and users.</p>
```

---

## Links and accessibility
Use descriptive text for links to give search engines and users context.

```html
<a href="/blog/html-seo">Read our HTML SEO guide</a>
```

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SEO-friendly HTML Example</title>
    <meta name="description" content="A beginner-friendly HTML page with strong SEO best practices.">
  </head>
  <body>
    <header>
      <h1>SEO-friendly HTML</h1>
    </header>

    <main>
      <section>
        <h2>Write meaningful headings</h2>
        <p>Use headings to describe the structure of the page and the content below.</p>
      </section>

      <section>
        <h2>Use quality links</h2>
        <p>
          Learn more from the <a href="https://developer.mozilla.org">MDN Web Docs</a> on HTML and accessibility.
        </p>
      </section>
    </main>
  </body>
</html>
```

---

## Common mistakes to avoid
- Using generic titles like "Home".
- Missing or duplicate meta descriptions.
- Writing unclear or short headings.
- Adding unnecessary keywords.
- Using non-semantic markup for important content.

---

## Quick practice
1. Create a page with a unique title and description.
2. Use an `<h1>` and nested headings.
3. Add a descriptive link to another page.
4. Review the page title and description in browser dev tools.

---

## Official references
- MDN: SEO basics: https://developer.mozilla.org/en-US/docs/Learn/SEO/Introduction
- Google: SEO starter guide: https://developers.google.com/search/docs/fundamentals/seo-starter-guide
