
# JavaScript Closures

## Overview
A closure is a function that remembers variables from its outer scope.

## Why this topic matters
Closures enable private state, function factories, and callback access to outer variables.

---

## Core concepts
- Inner functions retain access to outer variables.
- Closures are created when functions are defined.
- They can keep state between calls.
- Closures are common with callbacks and event handlers.

---

## Example
```js
function createCounter() {
  let count = 0
  return function() {
    count += 1
    return count
  }
}
const counter = createCounter()
console.log(counter())
console.log(counter())
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
1. Build a counter with closures.
2. Create a greeting function that remembers a name.
3. Explain why the inner function still accesses `count`.
4. Avoid storing large objects in closures when not needed.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
