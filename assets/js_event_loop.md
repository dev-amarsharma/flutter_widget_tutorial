
# JavaScript Event Loop

## Overview
The event loop handles JavaScript execution, asynchronous callbacks, and browser events.

## Why this topic matters
Understanding the event loop explains why async code runs later and why blocking code freezes the UI.

---

## Core concepts
- The call stack runs current code.
- The task queue holds callbacks waiting to run.
- Microtasks like promises run before the next task.
- Timers and events are processed after the current stack clears.

---

## Example
```js
console.log("Start")
setTimeout(() => console.log("Timeout"), 0)
Promise.resolve().then(() => console.log("Promise"))
console.log("End")
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
1. Predict the output order of a timeout and promise.
2. Use `setTimeout` to defer execution.
3. Observe promise callbacks running before timer callbacks.
4. Avoid heavy synchronous work inside the main thread.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
