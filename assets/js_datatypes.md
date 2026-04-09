
# JavaScript Data Types

## Overview
JavaScript has primitive types and reference types, each with different behavior.

## Why this topic matters
Recognizing data types helps you write correct comparisons and avoid type-related bugs.

---

## Core concepts
- Primitives: string, number, boolean, null, undefined, symbol, BigInt.
- Objects and arrays are reference types.
- Use `typeof` to inspect values.
- `null` means empty, while `undefined` means unassigned.

---

## Example
```js
const text = "Hello"
const amount = 42
const active = true
const user = { name: "Asha" }
console.log(typeof text, typeof user)
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
1. Log the type of several values.
2. Compare `null` and `undefined`.
3. Create an array and an object and inspect their types.
4. Use `BigInt` for a very large integer.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
