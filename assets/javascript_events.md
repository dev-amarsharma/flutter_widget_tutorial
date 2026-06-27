
# JavaScript Events

## Overview
Events let your code respond to user actions like clicks, key presses, and form submissions.

## Why this topic matters
Event handling is the core of interactive web applications and allows pages to react to input without reloading.

---

## Core concepts
- Use `addEventListener()` to attach handlers.
- The event object contains details like `target` and `type`.
- Events bubble from child to parent elements.
- Use `preventDefault()` to stop default browser actions.

---

## Example
```js
const link = document.querySelector("a")
link.addEventListener("click", event => {
  event.preventDefault()
  console.log("Link clicked")
})
window.addEventListener("keydown", event => {
  if (event.key === "Enter") {
    console.log("Enter pressed")
  }
})
```

---

## Best practices
1. Keep code readable and consistent.
2. Use the right feature for the job.
3. Prefer modern JavaScript syntax where appropriate.
4. Test your code in the browser or console.

---

## Common mistakes to avoid
1. Ignoring edge cases.
2. Using outdated syntax without reason.
3. Writing overly complex code.
4. Forgetting to handle errors or invalid input.

---

## Quick practice
1. Add a click handler to a button.
2. Prevent form submission and validate a field.
3. Use `event.target` to identify the clicked element.
4. Attach a single listener to a parent and delegate to children.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
