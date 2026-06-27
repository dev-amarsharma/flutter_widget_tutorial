
# JavaScript DOM Basics

## Overview
The DOM represents the HTML document as objects that JavaScript can inspect and modify.

## Why this topic matters
DOM basics are essential for updating content, handling events, and building interactive web pages.

---

## Core concepts
- Select elements with `querySelector` and `querySelectorAll`.
- Update content using `textContent`, `value`, and `innerHTML`.
- Create new elements with `createElement` and insert them into the DOM.
- Attach event listeners with `addEventListener`.

---

## Example
```js
const heading = document.querySelector("h1")
heading.textContent = "Updated heading"
const button = document.createElement("button")
button.textContent = "Click me"
document.body.appendChild(button)
button.addEventListener("click", () => console.log("Button clicked"))
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
1. Select an element and change its text.
2. Create and insert a new element into the page.
3. Add a click listener to a button.
4. Read a form field value and log it.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
