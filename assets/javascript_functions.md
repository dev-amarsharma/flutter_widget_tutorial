# JavaScript Functions

## Overview
Functions group reusable logic into named blocks. They help you:

- avoid repetition,
- organize behavior,
- pass inputs,
- return outputs,
- break large problems into smaller steps.

## Function declaration

```javascript
function greet(name) {
  return `Hello, ${name}`;
}
```

## Calling a function

```javascript
const message = greet("Asha");
console.log(message);
```

## Parameters and return values

- Parameters are the inputs a function receives.
- A return value is the result it sends back.

Example:

```javascript
function add(a, b) {
  return a + b;
}
```

## Arrow functions
Modern JavaScript also supports arrow functions:

```javascript
const double = (value) => value * 2;
```

Arrow functions are common for concise callbacks and small helpers.

## Why functions matter
Functions make code easier to:

- read,
- test,
- reuse,
- refactor.

## Best practices

- Give functions clear names based on behavior.
- Keep functions focused on one job.
- Return useful results instead of relying on hidden side effects.
- Break long functions into smaller pieces.

## Common mistakes

- Writing one giant function for many responsibilities.
- Using unclear names like `doStuff`.
- Forgetting to return a value when needed.
- Hiding too much logic inside deeply nested callbacks.

## References
- MDN JavaScript functions: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Functions
