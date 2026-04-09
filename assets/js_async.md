
# JavaScript Async/Await

## Overview
`async` and `await` help you write asynchronous code that is easier to read.

## Why this topic matters
Async/await improves promise handling and makes asynchronous flows more straightforward.

---

## Core concepts
- Mark functions with `async`.
- Use `await` to wait for a promise.
- Handle errors with `try/catch`.
- Keep async functions focused.

---

## Example
```js
async function load() {
  try {
    const response = await fetch("https://api.example.com/data")
    const data = await response.json()
    console.log(data)
  } catch (error) {
    console.error(error)
  }
}
load()
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
1. Create an async function that awaits a promise.
2. Use `try/catch` around `await`.
3. Log a failure when the promise rejects.
4. Use `Promise.all()` for parallel requests.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
