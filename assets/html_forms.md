# HTML Forms

## Overview
HTML forms collect user input and send it to a server or script for processing.
They are the foundation for login screens, search bars, checkout flows, contact pages, and feedback widgets.

## Why this topic matters
Forms are one of the most common interfaces users interact with on the web.
Good form design improves usability, reduces errors, and makes data easier to submit and validate.

## Core concepts
- `<form>` is the container for fields and submission controls.
- `<label>` connects descriptive text to a form control.
- `<input>` handles one-line text, numbers, checkboxes, radios, and more.
- `<textarea>` is used for longer text.
- `<select>` creates dropdowns with options.
- `<button>` triggers form submission or custom actions.

---

## Basic form structure
```html
<form action="/submit" method="post">
  <label for="email">Email</label>
  <input id="email" name="email" type="email" required />

  <label for="message">Message</label>
  <textarea id="message" name="message" rows="4" required></textarea>

  <button type="submit">Send</button>
</form>
```

### Important form attributes
- `action` — URL where form data is sent.
- `method` — submission method (`get` or `post`).
- `enctype` — encoding type for file uploads (`multipart/form-data`).
- `novalidate` — disables browser validation.

---

## Useful input types
- `text` — default single-line input.
- `email` — validates email addresses.
- `password` — hides typed characters.
- `number` — numeric input with optional `min`/`max`.
- `url` — validates URL format.
- `tel` — telephone number input.
- `checkbox` / `radio` — make selections.
- `date`, `time`, `datetime-local` — browser date/time pickers.

Choosing the right input type gives users mobile-friendly keyboards and built-in validation.

---

## Labels and accessibility
Every form control should have a visible label or an accessible label.
This helps users understand fields and supports screen readers.

```html
<label for="username">Username</label>
<input id="username" name="username" type="text" required>
```

For custom or hidden inputs, use `aria-label` or `aria-labelledby` when needed.

---

## Validation and user feedback
Use built-in HTML validation with attributes like:
- `required`
- `minlength` / `maxlength`
- `pattern`
- `min` / `max`
- `step`

Example:
```html
<input type="password" name="password" minlength="8" required>
```

Add visible messages for validation errors so users can fix problems quickly.

---

## Form grouping and structure
Group related fields with `<fieldset>` and `<legend>`.
Use headings and spacing to keep the form clear.

```html
<fieldset>
  <legend>Shipping address</legend>
  <label for="address">Street</label>
  <input id="address" name="address" type="text" required>
</fieldset>
```

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Contact form</title>
  </head>
  <body>
    <h1>Contact us</h1>

    <form action="/contact" method="post">
      <label for="name">Name</label>
      <input id="name" name="name" type="text" required>

      <label for="email">Email</label>
      <input id="email" name="email" type="email" required>

      <label for="message">Message</label>
      <textarea id="message" name="message" rows="5" required></textarea>

      <button type="submit">Send message</button>
    </form>
  </body>
</html>
```

---

## Common mistakes to avoid
- Missing `label` elements for form fields.
- Using `type="text"` for every input.
- Leaving out `name` attributes, which prevents values from submitting.
- Relying only on placeholder text for instructions.
- Making forms too long without clear sections.

---

## Quick practice
1. Build a contact form with name, email, and message fields.
2. Add `required`, `type="email"`, and `minlength` where appropriate.
3. Use `fieldset` and `legend` for grouped inputs.
4. Test the form by submitting invalid data.

---

## Official references
- MDN: HTML forms: https://developer.mozilla.org/en-US/docs/Learn/Forms
- MDN: Using the form element: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/form
