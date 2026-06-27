
# JavaScript JSON

## Overview
JSON is a text format for exchanging structured data between systems and APIs.

## Why this topic matters
JSON is the primary data format used for API responses and browser storage.

---

## Core concepts
- Use `JSON.parse()` to read JSON strings.
- Use `JSON.stringify()` to write JSON.
- JSON supports objects, arrays, strings, numbers, booleans, and null.
- Keys in JSON must be strings.

---

## Example
```js
const json = `{"name":"Asha","age":30}`
const user = JSON.parse(json)
console.log(user.name)
const text = JSON.stringify({ success: true })
console.log(text)
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
1. Parse a JSON string and access a property.
2. Convert a JavaScript object to JSON.
3. Use `try/catch` around `JSON.parse()`.
4. Store JSON in `localStorage` after stringifying.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
