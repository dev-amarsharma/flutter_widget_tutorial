# HTML Tables

## Overview
HTML tables present tabular data in rows and columns.
Use tables for spreadsheets, pricing grids, schedules, and any data that belongs in a grid structure.

## Why this topic matters
Tables communicate structured information clearly and accessibly.
Using the correct table markup improves usability for screen readers and allows browsers to render data effectively.

---

## Table structure
```html
<table>
  <caption>Monthly sales report</caption>
  <thead>
    <tr>
      <th>Month</th>
      <th>Sales</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>January</td>
      <td>$5,000</td>
    </tr>
  </tbody>
</table>
```

### Important table elements
- `<table>` — root table container.
- `<caption>` — describes the table purpose.
- `<thead>` — header row group.
- `<tbody>` — body rows.
- `<tfoot>` — footer rows (optional).
- `<tr>` — table row.
- `<th>` — header cell.
- `<td>` — data cell.

---

## Accessible table headers
Use `<th>` for header cells and `scope` when needed.

```html
<tr>
  <th scope="col">Product</th>
  <th scope="col">Price</th>
</tr>
```

---

## Avoid tables for layout
Do not use tables to create page layouts or design elements.
Use CSS layout techniques instead and reserve tables for true tabular data.

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HTML Table example</title>
  </head>
  <body>
    <h1>Team availability</h1>

    <table>
      <caption>Weekly team availability</caption>
      <thead>
        <tr>
          <th scope="col">Day</th>
          <th scope="col">Available</th>
          <th scope="col">Notes</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>Monday</td>
          <td>Yes</td>
          <td>Morning meeting</td>
        </tr>
        <tr>
          <td>Tuesday</td>
          <td>No</td>
          <td>Offsite workshop</td>
        </tr>
      </tbody>
    </table>
  </body>
</html>
```

---

## Common mistakes to avoid
- Using tables for page layout instead of data.
- Omitting a `<caption>` for data tables.
- Leaving out `<th>` header cells.
- Mixing unrelated content inside table cells.
- Not using `<thead>`, `<tbody>`, or `<tfoot>` for larger tables.

---

## Quick practice
1. Create a table with a caption and header row.
2. Add three rows of data with `<td>` cells.
3. Use `scope="col"` on header cells.
4. Avoid using tables for a page layout.

---

## Official references
- MDN: `<table>` element: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/table
- MDN: Table elements: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/table#table_sections
