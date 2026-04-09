
# JavaScript Spread and Rest

## Overview
Spread and rest syntax use `...` to expand or collect values in arrays, objects, and function arguments.

## Why this topic matters
Spread and rest make it easier to work with variable arguments and to copy or merge data structures.

---

## Core concepts
- Use spread to expand arrays and objects.
- Use rest to collect remaining function arguments.
- Spread creates shallow copies.
- Rest works in parameter lists and destructuring.

---

## Example
```js
const numbers = [1, 2, 3]
const more = [...numbers, 4, 5]
const user = { name: "Asha", age: 30 }
const updated = { ...user, role: "developer" }
function sum(...values) {
  return values.reduce((total, value) => total + value, 0)
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
1. Combine two arrays with spread.
2. Copy an object and add a property.
3. Use rest parameters in a function.
4. Destructure an array and capture the remainder with rest.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
