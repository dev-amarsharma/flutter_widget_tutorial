
# JavaScript Promises

## Overview
Promises represent the result of asynchronous operations and let you handle success or failure.

## Why this topic matters
Promises are the foundation for modern async JavaScript and are used by APIs such as fetch.

---

## Core concepts
- States: pending, fulfilled, rejected.
- `.then()` handles success.
- `.catch()` handles errors.
- `.finally()` runs cleanup code.

---

## Example
```js
fetch("https://api.example.com/items")
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error(error))
  .finally(() => console.log("Done"))
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
1. Create a promise that resolves after a delay.
2. Use `.then()` to handle the value.
3. Add `.catch()` for errors.
4. Use `.finally()` for cleanup.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
