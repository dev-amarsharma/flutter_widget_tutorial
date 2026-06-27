# HTML Headings

## Overview
HTML headings define the structure of a page using `<h1>` through `<h6>`.
They create a logical outline that helps users and search engines understand content hierarchy.

## Why this topic matters
Headings make content scannable, improve accessibility, and boost SEO.
Using them correctly prevents confusion for screen readers and maintains a clear page outline.

## Core concepts
- `<h1>` is the top-level heading and should be used once per page for main topic.
- `<h2>` through `<h6>` create nested sections.
- Headings should follow a logical order without skipping levels.
- Headings are not for styling; use CSS for visual appearance.

---

## Proper heading structure
```html
<h1>Website title</h1>
<h2>About the project</h2>
<h3>Goals</h3>
<h2>How it works</h2>
```

### Best practices
- Use one `<h1>` per page or application shell.
- Do not jump from `<h1>` to `<h4>` without intermediate levels.
- Keep headings concise and descriptive.
- Use headings to reflect content organization, not just visual size.

---

## Accessibility and semantics
Screen readers and assistive technologies rely on headings to navigate content.
A well-formed heading outline helps users move directly to the section they need.

Example:
```html
<h1>Blog: Web development</h1>
<h2>HTML fundamentals</h2>
<h3>Headings and structure</h3>
<h2>CSS fundamentals</h2>
```

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Heading structure example</title>
  </head>
  <body>
    <h1>Recipe: Chocolate chip cookies</h1>

    <section>
      <h2>Ingredients</h2>
      <ul>
        <li>Flour</li>
        <li>Sugar</li>
        <li>Chocolate chips</li>
      </ul>
    </section>

    <section>
      <h2>Instructions</h2>
      <h3>Step 1: Mix ingredients</h3>
      <p>Combine flour, sugar, and butter in a bowl.</p>
      <h3>Step 2: Bake</h3>
      <p>Bake at 350°F for 12 minutes.</p>
    </section>
  </body>
</html>
```

---

## Common mistakes to avoid
- Skipping heading levels (for example, jumping from `<h2>` to `<h4>`).
- Using headings for styling instead of structure.
- Repeating the same heading text without a clear hierarchy.
- Not using an `<h1>` on a page with main content.
- Using multiple `<h1>` elements for unrelated sections.

---

## Quick practice
1. Write a page outline using `<h1>`, `<h2>`, and `<h3>`.
2. Check that headings form a logical nested structure.
3. Keep headings short and clear.
4. Use CSS to style headings rather than changing heading levels.

---

## Official references
- MDN: Heading elements: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/Heading_Elements
- MDN: Document structure: https://developer.mozilla.org/en-US/docs/Learn/HTML/Introduction_to_HTML/Document_and_website_structure
