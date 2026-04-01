# Riverpod Basics

Provides a structured way to manage and consume app state without relying directly on widget tree inheritance.

---

## Description

Riverpod is a Flutter state management solution that helps organize application logic and state in a predictable way. It is often used when apps outgrow simple local state or basic provider patterns.

Common Riverpod concepts include:

- providers
- consumers
- reading and watching state
- separating business logic from UI

Riverpod is designed to make state easier to test, reuse, and reason about.

---

## Example

```dart
final counterProvider = StateProvider<int>((ref) => 0);

class CounterText extends ConsumerWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Text('Count: $count');
  }
}
```

---

## Key Points

- Providers expose values or logic that widgets can consume.
- `ref.watch` rebuilds when the provider value changes.
- `ref.read` gets a provider value without subscribing to updates.
- Riverpod keeps shared state more explicit than many ad hoc patterns.

---

## Quick Tips

- Start with simple providers before adding more advanced ones.
- Keep provider logic focused and easy to test.
- Use Riverpod to reduce state coupling inside widget classes.

---

## Things to Avoid

- Do not move every tiny local UI detail into global providers unnecessarily.
- Avoid mixing unclear business logic across many unrelated providers.
- Do not use `watch` where a one-time `read` is enough.

---

## See Also

- [`Provider Basics`](assets/provider_basics.md)
- [`BLoC Pattern`](assets/bloc_usage.md)
- [`setState Basics`](assets/setstate_basics.md)
