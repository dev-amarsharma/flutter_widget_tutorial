# HTML Attributes

## Overview
HTML attributes give elements additional meaning or behavior.
They appear inside opening tags as `name="value"` pairs, and they can affect appearance, accessibility, browser behavior, or script interaction.

```html
<a href="https://example.com" target="_blank">Visit site</a>
```

Here:
- `href` tells the browser where the link goes.
- `target="_blank"` opens the destination in a new tab.

---

## Why attributes matter
Attributes are essential because they:
- connect HTML to resources (`href`, `src`),
- define how forms behave and validate (`type`, `required`, `autocomplete`),
- improve accessibility (`alt`, `aria-*`, `lang`),
- enable styling and scripting (`id`, `class`, `data-*`),
- control loading and interaction (`loading`, `disabled`, `autofocus`).

---

## Attribute syntax rules

### `name="value"` is the normal form
Most attributes require a value in quotes.

```html
<img src="profile.jpg" alt="Profile photo">
```

### Boolean attributes are either present or absent
A Boolean attribute is true when it appears and false when it is omitted.

```html
<input type="checkbox" checked>
<button disabled>Saving...</button>
```

### Use quotes for attribute values
Quoted values are more reliable and easier to read.

```html
<input type="email" placeholder="you@example.com">
```

### Some attributes accept multiple values
Attributes like `class`, `rel`, and `sizes` may contain space-separated or comma-separated lists.

```html
<link rel="stylesheet preload" href="styles.css" as="style">
```

---

## Common attribute categories

### 1) Global attributes (usable on most elements)
- `id` — unique identifier for one element.
- `class` — classes for styling or script selection.
- `hidden` — hides an element from rendering.
- `title` — advisory text shown as a tooltip.
- `lang` — language of the element content.
- `data-*` — custom data storage for JavaScript.

Example:
```html
<p id="intro" class="lead" lang="en" title="Introduction text">
  Welcome to HTML attributes.
</p>
```

### 2) Links and media attributes
- `<a href="...">` — destination URL.
- `<img src="..." alt="..." width="..." height="...">` — accessible image data.
- `<video controls src="...">` — video playback controls.
- `<audio controls src="...">` — audio playback.
- `<source src="..." type="...">` — fallback media sources.

### 3) Form-related attributes
- `type`, `name`, `value` — define field behavior and data.
- `required`, `readonly`, `disabled` — validation and interactivity.
- `min`, `max`, `maxlength`, `pattern` — validation constraints.
- `autocomplete`, `placeholder`, `autofocus` — user experience helpers.
- `for` — links labels to form controls.

### 4) ARIA and accessibility attributes
- `alt` — image description.
- `aria-label` / `aria-labelledby` — accessible names.
- `aria-hidden` — hide an element from assistive tech.
- `tabindex` — keyboard focus order.

---

## Using attributes for accessibility
1. Provide meaningful `alt` text for informative images.
2. Connect `<label>` and inputs with `for` and `id`.
3. Mark the page language with `lang="en"` on `<html>`.
4. Use native HTML semantics before adding ARIA.

```html
<label for="email">Email</label>
<input id="email" name="email" type="email" required autocomplete="email">
```

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Attributes Demo</title>
  </head>
  <body>
    <h1 class="page-title">Create an account</h1>

    <img
      src="avatar.png"
      alt="Default user avatar"
      loading="lazy"
      width="120"
      height="120"
    />

    <form>
      <label for="username">Username</label>
      <input
        id="username"
        name="username"
        type="text"
        required
        minlength="3"
        maxlength="20"
      />

      <label for="email">Email</label>
      <input
        id="email"
        name="email"
        type="email"
        required
        autocomplete="email"
      />

      <button type="submit">Sign up</button>
    </form>
  </body>
</html>
```

---

## Common mistakes to avoid
- Forgetting `alt` on informative images.
- Reusing the same `id` value more than once.
- Using `disabled` instead of `readonly` when you need data submission.
- Overusing `style` attributes instead of external CSS.
- Adding ARIA roles or properties that conflict with built-in HTML behaviors.

---

## Quick practice
1. Create an image element with `src`, `alt`, `width`, and `height`.
2. Add a form field with `label`, `id`, `name`, and `required`.
3. Use `data-*` attributes to attach custom metadata for JavaScript.
4. Add `lang="en"` to the root `<html>` tag.

---

## Official references
- MDN: HTML attributes overview: https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes
- MDN: Global attributes reference: https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes
- WHATWG HTML Living Standard: https://html.spec.whatwg.org/multipage/syntax.html#attributes-2
