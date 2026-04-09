
# JavaScript Fetch Basics

## Overview
The Fetch API lets you request resources from the network using modern promise-based syntax.

## Why this topic matters
Fetch is the standard way to load JSON, images, and API data in browser applications.

---

## Core concepts
- `fetch()` returns a promise.
- Use `response.json()` to parse JSON.
- Handle network and HTTP errors.
- Use `async/await` for readable asynchronous code.

---

## Example
```js
async function loadData() {
  const response = await fetch("https://api.example.com/data")
  if (!response.ok) throw new Error("Network response was not ok")
  const data = await response.json()
  console.log(data)
}
loadData().catch(error => console.error(error))
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
1. Fetch JSON from a public API and log the result.
2. Show an error message when the request fails.
3. Send a POST request with JSON.
4. Use `finally` to hide a loading state.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
