
# JavaScript Prototypes

## Overview
Prototypes allow objects to inherit properties and methods from other objects.

## Why this topic matters
Prototypes are the mechanism behind JavaScript’s inheritance model and shared behavior.

---

## Core concepts
- Every object has a prototype.
- Constructor functions and classes set prototypes.
- Methods on the prototype are shared by instances.
- `Object.create()` makes objects with a specific prototype.

---

## Example
```js
function Person(name) {
  this.name = name
}
Person.prototype.greet = function() {
  return `Hello, ${this.name}`
}
const alice = new Person("Alice")
console.log(alice.greet())
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
1. Create a constructor function and add a prototype method.
2. Create two instances and call the shared method.
3. Inspect `instanceof` for an object.
4. Avoid modifying built-in prototypes like `Array.prototype`.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
