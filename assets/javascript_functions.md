
# JavaScript Functions

## Overview
Functions are reusable blocks of code that accept inputs and return outputs.

## Why this topic matters
Functions make code modular, easier to test, and less repetitive.

---

## Core concepts
- Declare functions with `function` or assign them to variables.
- Use parameters to receive data and `return` to send results.
- Functions are first-class values in JavaScript.
- Arrow functions provide a concise syntax.

---

## Example
```js
function greet(name) {
  return `Hello, ${name}!`
}
const message = greet("Asha")
console.log(message)
const add = (a, b) => a + b
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
1. Write a function that formats a name.
2. Create a function that returns the square of a number.
3. Use an arrow function for a callback.
4. Pass a function as an argument to another function.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
