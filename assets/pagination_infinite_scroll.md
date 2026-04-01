# Pagination and Infinite Scroll

Loads data in smaller chunks instead of fetching everything at once.

---

## Description

Pagination helps apps handle large datasets efficiently. Infinite scroll builds on pagination by loading more data when the user nears the bottom of a list.

Common benefits:

- better performance
- lower memory usage
- faster initial load
- smoother experience with large APIs

---

## Example

```dart
final ScrollController controller = ScrollController();

void setupPagination() {
  controller.addListener(() {
    if (controller.position.pixels >=
        controller.position.maxScrollExtent - 200) {
      loadNextPage();
    }
  });
}
```

---

## Key Points

- Fetch data page by page instead of all at once.
- Track loading state so you do not request the same page repeatedly.
- Stop requesting more data when the backend says there is no next page.
- Show loading indicators at the end of the list when fetching more data.

---

## Quick Tips

- Keep page index or cursor state in one place.
- Debounce or guard repeated load triggers.
- Handle empty first-page results differently from empty later pages.

---

## Things to Avoid

- Do not fire duplicate requests while a page is already loading.
- Avoid assuming more pages always exist.
- Do not mix pagination logic directly into complex UI code without structure.

---

## See Also

- [`ListView`](assets/listview.md)
- [`HTTP Requests`](assets/http_requests.md)
- [`Loading and Empty States`](assets/loading_empty_states.md)
