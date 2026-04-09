
# JavaScript Debounce & Throttle

## Overview
Debounce and throttle limit how often a function runs for performance-sensitive events.

## Why this topic matters
These techniques reduce work for frequent events like scrolling, resizing, and typing.

---

## Core concepts
- Debounce delays execution until activity stops.
- Throttle runs at most once per interval.
- Both are useful for event handlers.
- Debounce is ideal for input validation and resize events.

---

## Example
```js
function debounce(fn, delay) {
  let timer
  return (...args) => {
    clearTimeout(timer)
    timer = setTimeout(() => fn(...args), delay)
  }
}
const handleResize = debounce(() => {
  console.log("Resized")
}, 250)
window.addEventListener("resize", handleResize)
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
1. Create a debounced resize handler.
2. Throttle a scroll callback.
3. Compare the number of function calls with and without debounce.
4. Clear timers when no longer needed.

---

## Official references
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
