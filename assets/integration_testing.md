# Integration Testing

## Overview
Integration tests verify how multiple parts of an app work together. Android's testing guidance describes tests by scope and where they run. Integration tests usually sit between small unit tests and full end-to-end UI tests.

## Where integration tests fit
Android's testing docs describe:

- small tests: focus on a single method or class
- medium tests: check integration between two or more units
- big tests: verify larger flows such as screens or end-to-end behavior

Integration testing is often a medium or big test, depending on how much of the app is involved.

## Local vs instrumented
- Local tests run on your development machine and are usually fast.
- Instrumented tests run on a real or emulated Android device.

Android notes that small integration checks can still be instrumented, for example when verifying framework features such as a SQLite database on device.

## Practical examples
- repository + local database integration
- ViewModel + repository + fake network layer
- navigation flow across multiple screens
- DAO behavior against a real Room database

## Best practices
- Prefer the smallest test scope that still verifies the collaboration you care about.
- Use fakes or test doubles when full production dependencies are unnecessary.
- Reserve expensive UI-level integration tests for important user flows.
- Keep assertions focused on behavior, not implementation details.

## Common mistakes
- Writing only end-to-end tests and skipping smaller tests.
- Testing too many unrelated concerns in one integration test.
- Making integration tests flaky by depending on real network calls.

## References
- Android testing fundamentals: https://developer.android.com/training/testing/fundamentals
- Build local unit tests: https://developer.android.com/training/testing/local-tests
