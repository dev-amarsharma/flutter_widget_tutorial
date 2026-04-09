
# JavaScript Scope

## Overview
Scope determines where variables and functions are available in code.

## Why this topic matters
Scope prevents name collisions and controls which values can be accessed from different parts of a program.

---

## Core concepts
- Global scope is available throughout the page.
- Function scope contains variables declared inside functions.
- Block scope applies to `let` and `const` inside `{}`.
- The scope chain resolves identifiers from inner to outer scopes.

---

## Example
```js
const globalValue = 10
function showValue() {
  const localValue = 5
  console.log(globalValue, localValue)
}
showValue()
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
1. Declare a `const` in global scope and log it inside a function.
2. Declare a `let` inside a block and show it is not available outside.
3. Compare `var` scope with `let` scope.
4. Avoid reusing variable names in nested scopes.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
