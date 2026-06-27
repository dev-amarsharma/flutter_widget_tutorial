# HTML Links and Images

## Overview
Links and images are foundational HTML features.
Links connect pages and resources, while images display visual content with descriptive alternatives.

## Why this topic matters
Most pages combine links and images together for navigation, branding, and content.
Understanding both helps you create accessible, navigable, and responsive websites.

---

## Links
The `<a>` element creates hyperlinks.

```html
<a href="https://developer.mozilla.org/">Visit MDN</a>
```

### Key link points
- `href` defines the destination.
- Use descriptive link text.
- Add `target="_blank"` and `rel="noopener noreferrer"` for external links.
- Avoid using `<a>` only for styling.

---

## Images
The `<img>` element shows an image and should include `alt` text.

```html
<img src="logo.png" alt="App logo" width="120" height="80">
```

### Important image attributes
- `src` — the image file.
- `alt` — alternative text for accessibility.
- `width` / `height` — reserve space and prevent layout shifts.
- `loading="lazy"` — delay loading off-screen images.

---

## Relative vs absolute paths
- Relative paths: `images/logo.png` or `../assets/picture.jpg`
- Absolute URLs: `https://example.com/image.png`

```html
<a href="about.html">About</a>
<img src="images/photo.jpg" alt="Mountain view">
```

---

## Combining links and images
Images inside links are common for logos and clickable cards.
Provide a meaningful `alt` attribute on the image.

```html
<a href="index.html">
  <img src="logo.png" alt="Company logo">
</a>
```

---

## Accessibility and best practices
1. Use image `alt` text that describes the content or function.
2. If an image is purely decorative, use `alt=""`.
3. Make link text descriptive and unique.
4. Provide text alternatives for linked images.
5. Avoid using images as the only source of important text.

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Links and images example</title>
  </head>
  <body>
    <h1>Learn HTML links and images</h1>

    <p>
      Visit the <a href="https://developer.mozilla.org/">MDN Web Docs</a> for more tutorials.
    </p>

    <p>
      Click the logo to return to the homepage:
      <a href="index.html">
        <img src="logo.png" alt="Homepage logo" width="150" height="50">
      </a>
    </p>

    <p>
      Use relative paths for local resources and absolute URLs for external links.
    </p>
  </body>
</html>
```

---

## Common mistakes to avoid
- Using generic link text like "click here".
- Leaving out `alt` text for meaningful images.
- Using images for text without providing a text alternative.
- Opening external links in new tabs without `rel="noopener noreferrer"`.
- Not testing relative paths for both local and deployed pages.

---

## Quick practice
1. Add a text link and an image to a page.
2. Use a local image source and an external link.
3. Wrap an image in a link and give the image a descriptive `alt`.
4. Use lazy loading on a non-critical image.

---

## Official references
- MDN: Creating links: https://developer.mozilla.org/en-US/docs/Learn/HTML/Introduction_to_HTML/Creating_hyperlinks
- MDN: `<img>` element: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/img
