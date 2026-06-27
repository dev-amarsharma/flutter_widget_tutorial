
# JavaScript Loops

## Overview
Loops repeat code while a condition is true or over items in a collection.

## Why this topic matters
Loops make it easy to process arrays, generate repeated output, and handle lists of values.

---

## Core concepts
- `for` loops use an index to iterate.
- `while` loops continue until a condition changes.
- `for...of` works with iterable values.
- `forEach` calls a callback for each array element.

---

## Example
```js
const numbers = [1, 2, 3]
for (let i = 0; i < numbers.length; i++) {
  console.log(numbers[i])
}
for (const value of numbers) {
  console.log(value * 2)
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
1. Print numbers from 1 to 5 with a `for` loop.
2. Sum an array with `for...of`.
3. Use `while` to count down.
4. Log each array item with `forEach`.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
