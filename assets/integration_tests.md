# Integration Tests

Verifies that larger user flows work across multiple screens and systems.

---

## Description

Integration tests check how the app behaves when multiple parts work together. They are useful for flows such as:

- sign in
- form submission
- navigation across screens
- loading real or mocked backend data
- complete user journeys

They cover broader behavior than widget tests.

---

## Example

```dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('user can increment counter flow', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);
  });
}
```

---

## Key Points

- Integration tests validate end-to-end or near end-to-end flows.
- They usually cover more real app behavior than widget tests.
- `pumpAndSettle` is often useful when waiting for animations or async UI to finish.
- Good integration tests focus on realistic user journeys.

---

## Quick Tips

- Start with the most important critical flows.
- Keep test environments predictable.
- Use integration tests to catch flow-level regressions, not tiny UI details only.

---

## Things to Avoid

- Do not rely on brittle timing assumptions when waiting for app state.
- Avoid covering every tiny detail in one giant integration test.
- Do not skip smaller unit and widget tests just because integration tests exist.

---

## See Also

- [`Widget Tests`](assets/widget_tests.md)
- [`Firebase Authentication`](assets/firebase_authentication.md)
- [`Loading and Empty States`](assets/loading_empty_states.md)
