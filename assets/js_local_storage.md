
# JavaScript Local Storage

## Overview
`localStorage` stores key/value strings in the browser that persist across sessions.

## Why this topic matters
Local storage is useful for saving preferences, drafts, and offline-friendly state.

---

## Core concepts
- Use `localStorage.setItem(key, value)` to store data.
- Read values with `localStorage.getItem(key)`.
- Remove data with `localStorage.removeItem(key)`.
- Data persists until cleared.

---

## Example
```js
localStorage.setItem("theme", "dark")
const theme = localStorage.getItem("theme")
console.log(theme)
localStorage.removeItem("theme")
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
1. Save a preference in local storage.
2. Read it back and apply it.
3. Store an object with `JSON.stringify()`.
4. Clear the stored value when it is no longer needed.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
