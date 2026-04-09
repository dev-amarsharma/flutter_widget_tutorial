# Accessibility

## Overview
Accessibility means building web pages so people with disabilities can perceive, understand, navigate, and interact with the content.
It includes using semantic HTML, providing text alternatives, supporting keyboard navigation, and avoiding inaccessible patterns.

## Why this topic matters
Accessible pages reach more users, comply with legal standards, and often work better for everyone.
Good accessibility also improves SEO, usability, and long-term maintainability.

## Core accessibility concepts
- Use semantic HTML elements like `header`, `nav`, `main`, `section`, `article`, `button`, and `form`.
- Provide meaningful labels with `label`, `aria-label`, and `aria-labelledby` when needed.
- Add alternative text with `alt` for images and captions with `figcaption` for complex visuals.
- Ensure keyboard users can tab through interactive elements and that custom controls expose appropriate roles/states.
- Avoid relying only on color, visual position, or hover interactions.

## Real example
```html
<header>
  <h1>Conference registration</h1>
  <nav aria-label="Main navigation">
    <ul>
      <li><a href="#schedule">Schedule</a></li>
      <li><a href="#speakers">Speakers</a></li>
      <li><a href="#register">Register</a></li>
    </ul>
  </nav>
</header>

<main>
  <section id="register">
    <h2>Register for the event</h2>
    <form>
      <label for="name">Name</label>
      <input id="name" name="name" type="text" required />

      <label for="email">Email</label>
      <input id="email" name="email" type="email" required />

      <button type="submit">Submit registration</button>
    </form>
  </section>
</main>
```

## Practical accessibility habits
1. Add `alt` text for all informative images and use empty `alt=""` for decorative images.
2. Use explicit `label` elements connected to form controls with `for` and `id`.
3. Mark page structure with headings (`h1`..`h6`) in logical order.
4. Keep interactive elements native when possible (e.g. use `<button>` for buttons, `<a>` for links).
5. Test with keyboard only and with a screen reader if available.

## Common accessibility mistakes
- Missing `alt` text on images or using text like `image.jpg`.
- Using `<div>` or `<span>` as buttons without proper role/keyboard support.
- Skipping label associations for form fields.
- Using heading levels out of sequence (jumping from `h1` to `h4`).
- Relying solely on color to convey information.

## Quick practice
1. Build a simple contact form with labels, input types, and a submit button.
2. Add a navigation list with `aria-label="Main navigation"`.
3. Convert a visual-only component into semantic HTML with headings and landmarks.
4. Validate the page with browser accessibility tools or the WAVE extension.

## Official references
- MDN: Accessibility introduction: https://developer.mozilla.org/en-US/docs/Learn/Accessibility/What_is_accessibility
- MDN: Semantic HTML and accessibility: https://developer.mozilla.org/en-US/docs/Learn/Accessibility/HTML
- W3C: Web Content Accessibility Guidelines (WCAG): https://www.w3.org/WAI/standards-guidelines/wcag/
