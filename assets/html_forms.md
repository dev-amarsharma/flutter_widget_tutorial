# HTML Forms

## Overview
HTML forms collect user input. They are commonly used for:

- sign in screens,
- search bars,
- checkout flows,
- contact pages,
- feedback forms.

## Basic form example

```html
<form>
  <label for="email">Email</label>
  <input id="email" type="email" />

  <label for="message">Message</label>
  <textarea id="message"></textarea>

  <button type="submit">Send</button>
</form>
```

## Common form elements

- `<form>` wraps the input controls.
- `<label>` describes an input.
- `<input>` handles short text and many specialized input types.
- `<textarea>` is for multi-line text.
- `<select>` creates a dropdown.
- `<button>` triggers submission or another action.

## Useful input types

- `text`
- `email`
- `password`
- `number`
- `checkbox`
- `radio`
- `date`

Choosing the right type improves user experience and browser validation.

## Labels and accessibility
Every important input should have a label. This helps:

- users understand the field,
- screen readers identify controls,
- larger click targets for better usability.

## Form submission
Forms can submit data to a server using attributes such as:

- `action`
- `method`

Example:

```html
<form action="/submit" method="post">
  <input name="userName" type="text" />
  <button type="submit">Save</button>
</form>
```

## Best practices

- Use labels for all fields.
- Choose the correct input type.
- Keep forms short and clear.
- Group related fields logically.

## Common mistakes

- Missing labels.
- Using text inputs for everything.
- Not setting useful `name` attributes.
- Making forms too long without structure.

## References
- MDN HTML forms: https://developer.mozilla.org/en-US/docs/Learn_web_development/Extensions/Forms
