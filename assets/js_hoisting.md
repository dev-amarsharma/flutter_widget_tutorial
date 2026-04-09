
# JavaScript Hoisting

## Overview
Hoisting is JavaScript’s runtime behavior that moves declarations to the top of their scope.

## Why this topic matters
Hoisting affects how variables and functions are initialized and helps explain why some declarations behave differently.

---

## Core concepts
- `var` declarations hoist to the top of function scope.
- `let` and `const` are hoisted but not initialized until execution reaches them.
- Function declarations are hoisted with their definitions.
- The temporal dead zone applies to `let` and `const`.

---

## Example
```js
console.log(x) // undefined
var x = 5

console.log(y) // ReferenceError
let y = 10

function greet() {
  return "Hello"
}
console.log(greet())
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
1. Compare `var` and `let` access before declaration.
2. Observe the temporal dead zone with `const`.
3. Call a function declaration before it appears.
4. Avoid relying on hoisting in your code.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
