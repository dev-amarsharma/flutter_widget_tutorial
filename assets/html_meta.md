# Meta Tags

## Overview
`<meta>` tags provide metadata about the HTML document.
They live in the document `<head>` and can define character encoding, viewport settings, page description, and sharing data for social networks.

## Why this topic matters
Meta tags help browsers render your page correctly, improve SEO, and enable better previews for social sharing.
A correct head section is essential for modern responsive pages.

---

## Key meta tag examples
```html
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="A short description of the page">
```

### Common meta tag uses
- `charset` — document character encoding.
- `viewport` — mobile layout and scaling.
- `description` — page summary for search engines.
- `author` — author name.
- `theme-color` — browser UI color on mobile.

---

## HTML head structure
```html
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="An accessible HTML learning page.">
  <title>HTML Meta tags</title>
</head>
```

---

## Social sharing and SEO
Add Open Graph and Twitter card metadata for rich previews.

```html
<meta property="og:title" content="My page title">
<meta property="og:description" content="A short summary of the page">
<meta property="og:image" content="https://example.com/preview.png">
<meta name="twitter:card" content="summary_large_image">
```

---

## Accessibility and best practices
1. Always include `<meta charset="UTF-8">` first in the head.
2. Use `viewport` to make pages responsive on mobile.
3. Write a clear `description` for search engines.
4. Keep metadata accurate and up to date.
5. Avoid duplicate or conflicting meta tags.

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="A beginner-friendly guide to HTML meta tags.">
    <meta name="author" content="Your Name">
    <meta property="og:title" content="HTML meta tags guide">
    <meta property="og:description" content="Learn how to use meta tags for SEO and responsive pages.">
    <meta name="twitter:card" content="summary_large_image">
    <title>Meta Tags Example</title>
  </head>
  <body>
    <h1>Meta Tag Example</h1>
    <p>Open this page source to inspect the `<meta>` tags.</p>
  </body>
</html>
```

---

## Common mistakes to avoid
- Omitting `charset="UTF-8"`.
- Leaving out the viewport tag on mobile pages.
- Writing a missing or generic description.
- Using inline CSS to control responsive design instead of viewport metadata.
- Duplicating meta tags with conflicting values.

---

## Quick practice
1. Add `charset`, `viewport`, and `description` meta tags.
2. Use a meaningful page title.
3. Add Open Graph metadata for social previews.
4. Inspect the page head in browser developer tools.

---

## Official references
- MDN: `<meta>` element: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meta
- MDN: HTML head metadata: https://developer.mozilla.org/en-US/docs/Learn/HTML/Introduction_to_HTML/The_head_metadata_in_HTML
