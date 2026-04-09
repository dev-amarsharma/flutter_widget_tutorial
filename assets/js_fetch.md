
# JavaScript Fetch API

## Overview
The Fetch API is the modern standard for making network requests from browser JavaScript.

## Why this topic matters
Fetch is used for APIs, AJAX, and loading remote resources in client-side applications.

---

## Core concepts
- `fetch(url)` returns a promise for the response.
- Use `response.json()` for JSON data.
- Handle HTTP errors and network failures.
- Send request bodies with `POST` and headers.

---

## Example
```js
fetch("https://api.example.com/data")
  .then(response => {
    if (!response.ok) throw new Error("HTTP error")
    return response.json()
  })
  .then(data => console.log(data))
  .catch(error => console.error(error))
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
1. Fetch data from an API and log it.
2. Check `response.ok` before parsing.
3. Send JSON in a POST request.
4. Handle errors with `.catch()`.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
