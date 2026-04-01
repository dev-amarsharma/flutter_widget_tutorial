# go_router Basics

Introduces declarative routing in Flutter using the `go_router` package.

---

## Description

`go_router` is a popular Flutter routing package that helps manage navigation with a more structured, declarative API. It is useful when apps grow beyond simple push and pop flows and need clearer route definitions.

- **Common use cases:**
  - Centralizing route configuration
  - Navigating with path-based URLs
  - Handling deep links
  - Managing nested navigation in larger apps

---

## Example

```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) => const DetailsPage(),
    ),
  ],
);
```

---

## Key Points

- `go_router` is a package, not a built-in widget.
- Routes are declared up front.
- It supports URL-based navigation and deep linking.
- It can simplify navigation in medium and large apps.

---

## Quick Tips

- Keep route definitions grouped in one place.
- Name screens clearly and keep path structures predictable.
- Start simple before adding nested route complexity.

---

## Things to Avoid

- Avoid mixing too many navigation patterns at once.
- Avoid unclear route names and inconsistent paths.
- Do not introduce `go_router` if simple `Navigator` usage already solves your app cleanly.

---

## See Also

- [`Navigator push/pop`](assets/navigator.md)
- [`MaterialApp`](assets/materialapp.md)
