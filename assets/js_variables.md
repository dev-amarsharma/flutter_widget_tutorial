# JavaScript Variables

## Overview
Variables store values so your code can refer to them by name. JavaScript supports `const`, `let`, and `var`, with `const` and `let` as the modern choices.

## Why this topic matters
Variables are the fundamental way to manage data and state in programs. Choosing the correct declaration affects readability, scope, and behavior.

---

## Core concepts
- `const` declares values that should not be reassigned.
- `let` declares variables that may change later.
- `var` is function-scoped and is generally avoided in modern code.
- Use descriptive names and avoid global variables when possible.

---

## Example
```js
const name = "Asha"
let count = 1
count = count + 1
console.log(`${name} has ${count} notifications`)
```

---

## Best practices
1. Prefer `const` for values that do not change.
2. Use `let` only when reassignment is required.
3. Keep variable names descriptive and consistent.
4. Avoid unnecessary global variables.

---

## Common mistakes to avoid
1. Redeclaring the same variable using `var`, `let`, or `const` incorrectly.
2. Using `const` for values that need to change.
3. Forgetting that `const` objects and arrays can still mutate their contents.
4. Naming variables too generically.

---

## Quick practice
1. Declare a `const` and log it.
2. Declare a `let`, update it, and log the result.
3. Convert a `var` example to `let`/`const`.
4. Use a template literal to combine text and variables.

---

## Official references
- MDN `const`: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/const
- MDN `let`: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/let
- MDN variable scope: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Grammar_and_types#Declarations
