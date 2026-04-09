
# JavaScript Functions

## Overview
Functions are reusable code blocks that perform actions and return results.

## Why this topic matters
Functions help separate logic into manageable parts and make code easier to read and reuse.

---

## Core concepts
- Declare functions with `function` or use function expressions.
- Use parameters and return values.
- Functions can be passed as values.
- Arrow functions are a concise alternative.

---

## Example
```js
function greet(name) {
  return `Hello, ${name}!`
}
console.log(greet("Asha"))
const square = x => x * x
console.log(square(4))
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
1. Write a function that adds two numbers.
2. Create an arrow function for a callback.
3. Return a formatted string from a function.
4. Pass one function into another as a parameter.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
