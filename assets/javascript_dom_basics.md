# JavaScript DOM Basics

## Overview
The DOM, or Document Object Model, is the browser’s representation of an HTML page. JavaScript can use the DOM to read and update page content.

## Selecting elements

```javascript
const title = document.querySelector("h1");
```

Common selectors:
- `document.querySelector()`
- `document.querySelectorAll()`
- `document.getElementById()`

## Updating content

```javascript
title.textContent = "Updated heading";
```

## Updating classes

```javascript
const card = document.querySelector(".card");
card.classList.add("active");
```

## Why DOM basics matter
- You can react to user input
- You can show or hide content
- You can update the page without a full reload

## Best practices
- Select elements clearly
- Avoid repeating the same lookup too often
- Keep DOM updates readable and small

## References
- MDN DOM introduction: https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction
