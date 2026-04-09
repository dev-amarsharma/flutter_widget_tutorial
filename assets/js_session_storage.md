
# JavaScript Session Storage

## Overview
`sessionStorage` stores data for the current tab and clears it when the tab closes.

## Why this topic matters
Session storage is useful for temporary page state such as form drafts or UI settings.

---

## Core concepts
- Use `setItem(key, value)` to store strings.
- Read values with `getItem(key)`.
- Remove items with `removeItem(key)`.
- Data lasts only for the current browser tab session.

---

## Example
```js
sessionStorage.setItem("draft", "Hello")
const draft = sessionStorage.getItem("draft")
console.log(draft)
sessionStorage.removeItem("draft")
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
1. Save a preference to session storage.
2. Read it back and use it on page load.
3. Store a small object with JSON.
4. Remove the value when it is no longer needed.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
