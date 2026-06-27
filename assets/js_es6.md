
# JavaScript ES6 Features

## Overview
ES6 introduced modern syntax like classes, arrow functions, and modules.

## Why this topic matters
Understanding ES6 helps you write clean, modern JavaScript code.

---

## Core concepts
- `let` and `const` improve scoping.
- Arrow functions shorten function syntax.
- Template literals simplify string interpolation.
- Classes provide a clearer object syntax.

---

## Example
```js
const name = "Asha"
const greet = () => `Hello, ${name}!`
class User {
  constructor(name) {
    this.name = name
  }
  sayHello() {
    return `Hi, ${this.name}`
  }
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
1. Replace `var` with `let` or `const`.
2. Use template literals with expressions.
3. Define a simple class with a method.
4. Use default parameter values.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
