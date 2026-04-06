# HTML Attributes

## Overview
HTML attributes provide **extra information** about elements. They are written in the opening tag and usually appear as `name="value"` pairs.

```html
<a href="https://example.com" target="_blank">Visit site</a>
```

In this example:
- `href` tells the browser where the link goes.
- `target="_blank"` tells the browser to open in a new tab/window.

---

## Why attributes matter
Attributes help you:
- connect pages and resources (`href`, `src`),
- improve accessibility (`alt`, `aria-*`),
- configure forms (`type`, `required`, `placeholder`),
- identify elements for styling/scripts (`class`, `id`),
- improve performance and behavior (`loading`, `defer`, `autocomplete`).

---

## Attribute syntax rules

### 1) Most attributes use `name="value"`
```html
<img src="profile.jpg" alt="Profile photo">
```

### 2) Some are Boolean attributes
Boolean attributes are either present or absent. If present, they are considered true.

```html
<input type="checkbox" checked>
<button disabled>Saving...</button>
```

### 3) Use quotes for values
Always prefer quoted values for readability and consistency.

```html
<input type="email" placeholder="you@example.com">
```

---

## Common attribute categories

## 1) Global attributes (usable on most elements)
- `id` — unique identifier for one element.
- `class` — reusable grouping for CSS/JS.
- `title` — advisory text, often shown as tooltip.
- `lang` — language of content (`en`, `es`, `fr`).
- `hidden` — hides an element from rendering.
- `style` — inline CSS (use sparingly).

Example:
```html
<p id="intro" class="lead" lang="en" title="Introduction text">
  Welcome to HTML attributes.
</p>
```

## 2) Link and media attributes
- `<a href="...">` for destinations.
- `<img src="..." alt="...">` for images + accessible description.
- `<video controls src="...">` for media controls.

## 3) Form-related attributes
- `type`, `name`, `value`
- `required`, `readonly`, `disabled`
- `min`, `max`, `maxlength`, `pattern`
- `autocomplete`, `placeholder`

---

## Accessibility-focused attribute habits
1. Always add meaningful `alt` text on informative images.
2. Use `label` + `for` with matching input `id`.
3. Set `lang` on the `<html>` element.
4. Use ARIA attributes only when semantic HTML is not enough.

```html
<label for="email">Email</label>
<input id="email" name="email" type="email" required autocomplete="email">
```

---

## Real-world mini example

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

    <img src="avatar.png" alt="Default user avatar" loading="lazy" width="120" height="120" />

    <form>
      <label for="username">Username</label>
      <input id="username" name="username" type="text" required minlength="3" maxlength="20" />

      <label for="email">Email</label>
      <input id="email" name="email" type="email" required autocomplete="email" />

      <button type="submit">Sign up</button>
    </form>
  </body>
</html>
```

---

## Common mistakes to avoid
- Missing `alt` on important images.
- Reusing the same `id` on multiple elements.
- Using `disabled` when you actually need `readonly`.
- Overusing inline `style` instead of external CSS.
- Adding ARIA attributes that conflict with native semantics.

---

## Quick practice
1. Create an `<img>` with `src`, `alt`, `width`, and `height`.
2. Build a form input that is `required` and validates an email.
3. Add unique `id` values and matching `label for` attributes.
4. Add `lang="en"` to the root `<html>` tag.

---

## Official references
- MDN: HTML attributes overview: https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes
- MDN: Global attributes reference: https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes
- WHATWG HTML Living Standard (attributes): https://html.spec.whatwg.org/multipage/syntax.html#attributes-2
