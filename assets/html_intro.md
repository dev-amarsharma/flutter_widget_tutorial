# HTML Introduction

## Overview
HTML stands for HyperText Markup Language. It is the standard language used to describe the structure of a web page.

HTML does not handle styling or complex behavior by itself. Instead:

- HTML defines content and structure.
- CSS controls presentation and layout.
- JavaScript adds behavior and interactivity.

## What HTML does
HTML organizes page content into meaningful elements such as:

- headings,
- paragraphs,
- links,
- images,
- lists,
- forms,
- sections of a page.

Browsers read HTML and render the page based on the elements and their attributes.

## A simple page

```html
<!DOCTYPE html>
<html>
  <head>
    <title>My First Page</title>
  </head>
  <body>
    <h1>Hello, Web</h1>
    <p>This is my first HTML page.</p>
  </body>
</html>
```

## Core document parts

- `<!DOCTYPE html>` tells the browser to use modern HTML.
- `<html>` wraps the entire document.
- `<head>` contains metadata such as the page title.
- `<body>` contains the visible content shown to users.

## Common use cases
HTML is used to build:

- landing pages,
- blog posts,
- dashboards,
- forms,
- e-commerce pages,
- documentation websites.

## Best practices

- Use semantic tags when possible.
- Keep the document structure clear and readable.
- Use heading levels in order.
- Prefer meaningful element names over generic wrappers.

## Common mistakes

- Forgetting the document structure.
- Using headings only for visual size instead of meaning.
- Putting visible page content inside `<head>`.
- Treating HTML as a styling language.

## Practice
1. Create a page with one heading and two paragraphs.
2. Add a link and an image.
3. Inspect the page in a browser and identify the `head` and `body`.

## References
- MDN HTML guide: https://developer.mozilla.org/en-US/docs/Web/HTML
