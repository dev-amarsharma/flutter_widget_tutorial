
# JavaScript Arrays and Objects

## Overview
Arrays and objects are the two primary data structures in JavaScript. Arrays hold ordered values while objects store keyed values.

## Why this topic matters
Arrays and objects are used everywhere in JavaScript programs to represent lists, records, and nested data.

---

## Core concepts
- Arrays are ordered and indexed.
- Objects use keys to store named properties.
- Both can contain values of any type, including other arrays and objects.
- Common array methods include `push`, `map`, `filter`, and `reduce`.

---

## Example
```js
const user = { name: "Asha", age: 30, tags: ["learner", "developer"] }
console.log(user.name)
const numbers = [1, 2, 3]
const doubled = numbers.map(n => n * 2)
console.log(doubled)
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
1. Create an object with user data and access a property.
2. Create an array of numbers and use `filter` to keep only even values.
3. Add a new item to an array with `push`.
4. Use `Object.keys()` to list object keys.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
