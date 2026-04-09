
# JavaScript this Keyword

## Overview
`this` refers to the current execution context and changes depending on how a function is called.

## Why this topic matters
Understanding `this` prevents bugs in methods, callbacks, and event handlers.

---

## Core concepts
- In methods, `this` refers to the owning object.
- In strict mode standalone functions, `this` is `undefined`.
- Arrow functions use lexical `this`.
- `call`, `apply`, and `bind` explicitly set `this`.

---

## Example
```js
const user = {
  name: "Asha",
  greet() {
    console.log(`Hi, ${this.name}`)
  }
}
user.greet()
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
1. Call a method and observe `this`.
2. Assign a method to a variable and see how `this` changes.
3. Use `bind` to preserve `this`.
4. Compare `this` inside an arrow function and a regular function.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
