
# JavaScript Events

## Overview
Events represent user interactions and browser lifecycle changes, triggering JavaScript handlers.

## Why this topic matters
Most interactive pages depend on event handling to respond to clicks, input, and navigation.

---

## Core concepts
- Use `addEventListener` to respond to events.
- Events bubble and can be stopped.
- `event.target` identifies the source element.
- `preventDefault()` cancels default actions.

---

## Example
```js
const button = document.querySelector("button")
button.addEventListener("click", event => {
  console.log("Button clicked", event.target)
})
window.addEventListener("resize", () => console.log("Window resized"))
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
1. Add a click event listener to a button.
2. Log the clicked element using `event.target`.
3. Prevent default form behavior.
4. Delegate clicks from a parent element.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
