# HTML Lists

## Overview
HTML lists group related items into structured content.
There are three main list types: unordered lists, ordered lists, and description lists.

## Why this topic matters
Lists improve readability and make related content easier to scan.
Using the correct list type preserves meaning and accessibility.

---

## Unordered lists
Use `<ul>` when the order of items does not matter.

```html
<ul>
  <li>HTML</li>
  <li>CSS</li>
  <li>JavaScript</li>
</ul>
```

## Ordered lists
Use `<ol>` when the order or sequence of items is important.

```html
<ol>
  <li>Open the editor</li>
  <li>Write the markup</li>
  <li>Preview the page</li>
</ol>
```

## Description lists
Use `<dl>` for pairs of terms and descriptions.

```html
<dl>
  <dt>HTML</dt>
  <dd>Defines the structure of web pages.</dd>
  <dt>CSS</dt>
  <dd>Controls presentation and layout.</dd>
</dl>
```

---

## Nested lists
Lists can contain other lists to show hierarchy.

```html
<ul>
  <li>Fruits
    <ul>
      <li>Apples</li>
      <li>Bananas</li>
    </ul>
  </li>
  <li>Vegetables</li>
</ul>
```

---

## Accessibility and best practices
1. Use lists for items that belong together.
2. Keep each `<li>` focused on one idea.
3. Avoid using lists for layout alone.
4. Use nested lists only when the structure is hierarchical.
5. Choose a description list for term/definition content.

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List examples</title>
  </head>
  <body>
    <h1>Simple shopping list</h1>
    <ul>
      <li>Milk</li>
      <li>Bread</li>
      <li>Eggs</li>
    </ul>

    <h2>Steps to prepare coffee</h2>
    <ol>
      <li>Boil water</li>
      <li>Add coffee grounds</li>
      <li>Pour into cup</li>
    </ol>

    <h2>Terms</h2>
    <dl>
      <dt>HTML</dt>
      <dd>HyperText Markup Language</dd>
      <dt>CSS</dt>
      <dd>Cascading Style Sheets</dd>
    </dl>
  </body>
</html>
```

---

## Common mistakes to avoid
- Using a list for layout only instead of meaningful content.
- Putting multiple sentences in a single list item unnecessarily.
- Skipping proper nesting when items are hierarchical.
- Using description lists for non-term/definition content.

---

## Quick practice
1. Create an unordered list of three favorite foods.
2. Create an ordered list of three steps to complete a task.
3. Add a description list for three technical terms.
4. Nest one list inside another for a subcategory.

---

## Official references
- MDN: HTML lists: https://developer.mozilla.org/en-US/docs/Learn/HTML/Introduction_to_HTML/HTML_text_fundamentals#lists
