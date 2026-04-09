
# JavaScript Arrays

## Overview
Arrays store ordered collections and are useful for lists of values.

## Why this topic matters
Arrays make it easy to iterate over data, process items, and transform lists in JavaScript.

---

## Core concepts
- Access array items by index.
- Use methods like `push`, `pop`, `map`, `filter`, and `reduce`.
- Arrays are zero-indexed.
- Arrays can contain any value type.

---

## Example
```js
const colors = ["red", "green", "blue"]
colors.push("yellow")
const upper = colors.map(color => color.toUpperCase())
console.log(upper)
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
1. Create an array of numbers and double them with `map`.
2. Filter out odd values.
3. Remove the first item with `shift`.
4. Join the array into a string.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
