
# JavaScript Timers

## Overview
`setTimeout` and `setInterval` schedule code to run after a delay or repeatedly.

## Why this topic matters
Timers are useful for delayed actions, animations, and polling without blocking the main thread.

---

## Core concepts
- `setTimeout(fn, ms)` runs once after a delay.
- `setInterval(fn, ms)` runs repeatedly.
- Cancel timers with `clearTimeout` or `clearInterval`.
- Timers are scheduled by the event loop.

---

## Example
```js
const timerId = setTimeout(() => {
  console.log("Delayed message")
}, 1000)
clearTimeout(timerId)
const intervalId = setInterval(() => {
  console.log("Repeat")
}, 500)
setTimeout(() => clearInterval(intervalId), 3000)
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
1. Use `setTimeout` to log a message after 1 second.
2. Use `setInterval` to count every second.
3. Clear the interval when done.
4. Cancel a timeout before it fires.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
