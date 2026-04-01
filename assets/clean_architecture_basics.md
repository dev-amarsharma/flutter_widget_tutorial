# Clean Architecture Basics

Helps organize app code into clear layers with separated responsibilities.

---

## Description

Clean architecture is a way of structuring code so that business rules, data access, and UI concerns are not tightly mixed together.

A common layered approach looks like this:

- presentation layer: widgets, screens, UI state
- domain layer: business rules and use cases
- data layer: repositories, APIs, local storage

This structure can make larger apps easier to scale, test, and maintain.

---

## Example

```dart
class GetPostsUseCase {
  final PostRepository repository;

  GetPostsUseCase(this.repository);

  Future<List<Post>> call() {
    return repository.fetchPosts();
  }
}
```

---

## Key Points

- Each layer should have a focused responsibility.
- UI should not depend directly on raw API details everywhere.
- Repositories help separate data sources from business logic.
- Use cases can keep domain actions explicit and testable.

---

## Quick Tips

- Start with light structure and grow it only when complexity demands it.
- Keep dependency direction clear.
- Use clean architecture to reduce coupling, not to add ceremony without value.

---

## Things to Avoid

- Do not over-engineer tiny apps with excessive abstraction.
- Avoid mixing API, database, and UI logic in the same widget classes.
- Do not create layers that have no practical purpose in your app.

---

## See Also

- [`REST API Integration`](assets/rest_api_integration.md)
- [`Provider Basics`](assets/provider_basics.md)
- [`BLoC Pattern`](assets/bloc_usage.md)
