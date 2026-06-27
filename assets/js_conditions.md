
# JavaScript Conditions

## Overview
Conditional statements choose between different actions based on expressions.

## Why this topic matters
Conditions let your code branch and make decisions based on user input and state.

---

## Core concepts
- Use `if`, `else if`, and `else`.
- Use `switch` for multiple discrete cases.
- Understand truthy and falsy values.
- Prefer `===` over `==` for comparisons.

---

## Example
```js
const score = 85
if (score >= 90) {
  console.log("Excellent")
} else if (score >= 75) {
  console.log("Good")
} else {
  console.log("Needs improvement")
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
1. Check whether a number is positive.
2. Use `switch` for weekday names.
3. Compare values with `===`.
4. Use a ternary for a simple assignment.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
