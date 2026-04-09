
# JavaScript DOM Manipulation

## Overview
DOM manipulation changes page elements, content, and styles using JavaScript.

## Why this topic matters
Updating the DOM enables dynamic content, interactive interfaces, and responsive behavior.

---

## Core concepts
- Select elements with `querySelector`.
- Change content with `textContent` and `innerHTML`.
- Modify classes with `classList`.
- Create and remove elements programmatically.

---

## Example
```js
const card = document.querySelector(".card")
card.textContent = "Updated content"
card.classList.add("active")
const badge = document.createElement("span")
badge.textContent = "New"
card.appendChild(badge)
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
1. Select an element and update its text.
2. Add a CSS class to an element.
3. Create and append a new DOM element.
4. Remove an element after a delay.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
