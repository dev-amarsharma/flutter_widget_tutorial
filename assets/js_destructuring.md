
# JavaScript Destructuring

## Overview
Destructuring extracts values from arrays or objects into variables with concise syntax.

## Why this topic matters
Destructuring reduces repetitive property access and makes assignments more readable.

---

## Core concepts
- Use array destructuring with `[]`.
- Use object destructuring with `{}`.
- Provide default values for missing fields.
- Use aliases to rename extracted values.

---

## Example
```js
const point = [10, 20]
const [x, y] = point
const user = { name: "Asha", role: "developer" }
const { name, role } = user
console.log(name, role)
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
1. Destructure the first two items of an array.
2. Extract object properties into variables.
3. Use a default value for missing data.
4. Destructure function parameters.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
