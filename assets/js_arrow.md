
# JavaScript Arrow Functions

## Overview
Arrow functions provide concise syntax for function expressions.

## Why this topic matters
Arrow functions are widely used for callbacks and inline functions in modern JavaScript.

---

## Core concepts
- Use `() => {}` for arrow functions.
- Omit braces and `return` for single expressions.
- Arrow functions use lexical `this`.
- They cannot be used as constructors.

---

## Example
```js
const add = (a, b) => a + b
const names = ["Asha", "Ravi"].map(name => name.toUpperCase())
console.log(add(2, 3))
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
1. Rewrite a simple function as an arrow function.
2. Use arrow functions with `map`.
3. Write a one-parameter arrow function.
4. Compare `this` inside a normal function vs an arrow function.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
