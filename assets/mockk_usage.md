# MockK Usage

## Overview
MockK is a Kotlin-focused mocking library often used in Android and JVM tests. The official MockK docs show a simple pattern: create a mock with `mockk<T>()`, stub behavior with `every { ... } returns ...`, verify calls with `verify { ... }`, and optionally call `confirmVerified(...)`.

## Basic example

```kotlin
val car = mockk<Car>()

every { car.drive(Direction.NORTH) } returns Outcome.OK

car.drive(Direction.NORTH)

verify { car.drive(Direction.NORTH) }
confirmVerified(car)
```

## Core concepts
- `mockk<T>()` creates a mock
- `every { ... } returns ...` stubs behavior
- `verify { ... }` checks that a call happened
- `justRun { ... }` is convenient for `Unit` functions
- `coEvery` and `coVerify` support suspend functions

## Useful annotations
MockK also supports annotations such as:

- `@MockK`
- `@RelaxedMockK`
- `@SpyK`
- `@InjectMockKs`

The docs show `MockKAnnotations.init(this)` to initialize annotated fields.

## Best practices
- Mock boundaries and dependencies, not the class under test's own logic.
- Verify important behavior, not every trivial implementation detail.
- Use coroutine-specific APIs for suspend functions.
- Keep tests readable and focused.

## Common mistakes
- Over-verifying internal details.
- Forgetting to use `coEvery` or `coVerify` for suspend functions.
- Making tests hard to understand with too much mocking.

## References
- MockK official docs: https://mockk.io/
