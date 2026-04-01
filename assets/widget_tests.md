# Widget Tests

Checks how Flutter widgets render and behave without running the full app on a device.

---

## Description

Widget tests focus on UI behavior at the widget level. They are useful for verifying:

- text and labels appear correctly
- buttons trigger expected behavior
- loading and error states render as expected
- widgets respond to user interaction

They are faster and more focused than full integration tests.

---

## Example

```dart
testWidgets('increments counter', (tester) async {
  await tester.pumpWidget(const MyApp());

  expect(find.text('0'), findsOneWidget);

  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();

  expect(find.text('1'), findsOneWidget);
});
```

---

## Key Points

- Widget tests use `testWidgets`.
- `WidgetTester` helps render widgets, tap controls, and inspect UI.
- `pumpWidget` builds the widget under test.
- `pump` advances frames after interaction or state changes.

---

## Quick Tips

- Test user-visible behavior instead of internal implementation details.
- Keep widget tests focused and small.
- Use finders like `find.text` and `find.byType` to assert UI state.

---

## Things to Avoid

- Do not over-test private implementation details.
- Avoid making one widget test responsible for too many unrelated behaviors.
- Do not forget to `pump` after actions that trigger UI updates.

---

## See Also

- [`Integration Tests`](assets/integration_tests.md)
- [`StatefulWidget`](assets/statefulwidget.md)
- [`Loading and Empty States`](assets/loading_empty_states.md)
