
# JavaScript Error Handling

## Overview
Error handling helps your code respond to unexpected problems instead of failing silently.

## Why this topic matters
Robust error handling makes applications more reliable and easier to debug.

---

## Core concepts
- Use `try`, `catch`, and `finally`.
- Throw custom errors with `throw`.
- Inspect `error.message` and `error.name`.
- Handle promise rejections with `.catch()`.

---

## Example
```js
try {
  const result = JSON.parse("invalid json")
  console.log(result)
} catch (error) {
  console.error("Parsing failed:", error.message)
} finally {
  console.log("Cleanup done")
}
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
1. Parse JSON with `try/catch`.
2. Throw an error for invalid input.
3. Handle a rejected promise.
4. Use `finally` for cleanup.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
