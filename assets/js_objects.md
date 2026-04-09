
# JavaScript Objects

## Overview
Objects are collections of key/value pairs that model structured data.

## Why this topic matters
Objects let you represent entities, settings, and records with properties and methods.

---

## Core concepts
- Create objects with `{}`.
- Access properties with dot or bracket notation.
- Define methods to add behavior.
- Objects can inherit from prototypes.

---

## Example
```js
const user = {
  name: "Asha",
  age: 30,
  greet() {
    return `Hi, ${this.name}`
  }
}
console.log(user.greet())
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
1. Create an object with properties and a method.
2. Access a property using bracket notation.
3. Add a new property to the object.
4. Use `Object.keys()` to list all keys.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
