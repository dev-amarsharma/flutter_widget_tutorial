# JavaScript Introduction

## Overview
JavaScript is the programming language of the browser. It is used to add behavior and interactivity to web pages.

With JavaScript you can:

- respond to user actions,
- update content dynamically,
- validate forms,
- call APIs,
- control UI state,
- build full web applications.

## Where JavaScript runs
JavaScript commonly runs:

- in web browsers,
- on servers with environments such as Node.js,
- in tooling and build systems.

For basic front-end work, JavaScript often works alongside HTML and CSS.

## Basic example

```javascript
const title = "Kotlin Compose Tutorial";
console.log(`Welcome to ${title}`);
```

## Adding JavaScript to a page

```html
<script>
  console.log("Page loaded");
</script>
```

Or link an external file:

```html
<script src="app.js"></script>
```

## Common uses in the browser

- handle button clicks,
- show or hide UI,
- update text without reloading,
- fetch remote data,
- react to form input.

## Best practices

- Keep code readable and small at first.
- Use descriptive names.
- Prefer `const` unless reassignment is needed.
- Separate structure, style, and behavior clearly.

## Common mistakes

- Mixing large amounts of JavaScript directly into HTML.
- Ignoring errors in the browser console.
- Reassigning values unnecessarily.
- Writing unclear variable names.

## References
- MDN JavaScript guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
