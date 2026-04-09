
# JavaScript Modules

## Overview
Modules split code into reusable files that export and import values.

## Why this topic matters
Modules make code easier to organize, reuse, and maintain in larger applications.

---

## Core concepts
- Use `export` to share values from a module.
- Use `import` to bring values into another file.
- Load modules with `<script type="module">`.
- Default exports provide a single main value.

---

## Example
```js
// math.js
export function add(a, b) {
  return a + b
}
// app.js
import { add } from "./math.js"
console.log(add(2, 3))
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
1. Export a function from one module.
2. Import and call it from another module.
3. Use a default export for a main value.
4. Load the script with `type="module"`.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
