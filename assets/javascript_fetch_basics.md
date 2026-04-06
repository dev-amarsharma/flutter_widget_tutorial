# JavaScript Fetch Basics

## Overview
The Fetch API lets JavaScript request data from a server. It is commonly used to load JSON from APIs.

## Basic example

```javascript
fetch("https://api.example.com/topics")
  .then((response) => response.json())
  .then((data) => {
    console.log(data);
  });
```

## Async/await version

```javascript
async function loadTopics() {
  const response = await fetch("https://api.example.com/topics");
  const data = await response.json();
  console.log(data);
}
```

## Important ideas
- Fetch returns a promise
- Responses often need parsing with `response.json()`
- Network calls can fail and should be handled carefully

## Best practices
- Check for errors
- Keep request logic readable
- Separate UI updates from fetch code when possible

## References
- MDN Fetch API: https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API
