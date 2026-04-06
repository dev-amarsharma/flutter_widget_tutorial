# JavaScript Variables

## Overview
JavaScript uses variables to store values that your code can read and update.

The modern declarations are:

- `const` for values that should not be reassigned,
- `let` for values that may change.

Older JavaScript also uses `var`, but modern code usually prefers `const` and `let`.

## Examples

```javascript
const appName = "Web Starter";
let lessonCount = 3;

lessonCount = lessonCount + 1;
```

## `const` vs `let`

- Use `const` by default.
- Use `let` when the variable must be reassigned.

Example:

```javascript
const userName = "Asha";
let currentStep = 1;
currentStep = 2;
```

## Common value types

- strings
- numbers
- booleans
- arrays
- objects
- `null`
- `undefined`

## Scope basics
Variables declared with `let` and `const` are block scoped:

```javascript
if (true) {
  const label = "Visible only here";
}
```

This improves predictability and avoids accidental leaks into outer scopes.

## Best practices

- Prefer `const` first.
- Use `let` only when reassignment is necessary.
- Avoid `var` in new code.
- Choose names that describe purpose clearly.

## Common mistakes

- Using `let` everywhere without need.
- Falling back to `var` in modern code.
- Reusing one variable for multiple unrelated meanings.
- Confusing reassignment with object mutation.

## References
- MDN JavaScript variables: https://developer.mozilla.org/en-US/docs/Learn_web_development/Core/Scripting/Variables
