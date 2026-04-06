# JavaScript Events

## Overview
Events let JavaScript respond when something happens in the browser, such as a click, input change, or form submission.

## Common events
- `click`
- `input`
- `change`
- `submit`
- `keydown`

## Adding an event listener

```javascript
const button = document.querySelector("button");

button.addEventListener("click", () => {
  console.log("Button clicked");
});
```

## Form example

```javascript
const form = document.querySelector("form");

form.addEventListener("submit", (event) => {
  event.preventDefault();
  console.log("Form handled in JavaScript");
});
```

## Best practices
- Keep handlers focused
- Name functions clearly
- Prevent default behavior only when needed

## References
- MDN events: https://developer.mozilla.org/en-US/docs/Learn_web_development/Core/Scripting/Events
