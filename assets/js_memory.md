
# JavaScript Memory Management

## Overview
JavaScript manages memory automatically, freeing values that are no longer reachable.

## Why this topic matters
Memory awareness helps you avoid leaks and write more efficient code, especially in long-running apps.

---

## Core concepts
- Primitives are stored by value.
- Objects and arrays are stored by reference.
- Garbage collection removes unreachable values.
- Closures and global references can keep memory alive.

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
1. Create a closure and observe its retained state.
2. Remove an event listener when a node is removed.
3. Clear a timer with `clearTimeout`.
4. Avoid global objects for temporary data.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
