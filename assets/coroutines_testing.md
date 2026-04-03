# Coroutines Testing

## Overview
Testing coroutine-based code requires control over timing, dispatchers, and completion. Android’s coroutine testing guide recommends the `kotlinx-coroutines-test` library and APIs like `runTest`.

These tools help make tests:

- deterministic
- fast
- less dependent on real time

## Core APIs
Common coroutine testing APIs include:

- `runTest`
- `TestDispatcher`
- `StandardTestDispatcher`
- `UnconfinedTestDispatcher`
- virtual time helpers like `advanceUntilIdle()`

## Example
```kotlin
@Test
fun loadsData() = runTest {
  val repository = FakeRepository()
  val result = repository.load()
  assertEquals("done", result)
}
```

## Why `runTest` matters
`runTest` creates a test coroutine scope and scheduler so you can:

- run suspending code in tests
- skip real delays with virtual time
- control execution more precisely

## Dispatcher replacement
Android guidance often recommends replacing the main dispatcher in tests when code under test depends on `Dispatchers.Main`. This keeps UI-oriented coroutine code testable without a real Android main thread.

## Best practices
- Use `runTest` for suspending test bodies.
- Inject dispatchers when production code depends on specific ones.
- Prefer fake dependencies over real network or database work in unit tests.
- Use virtual time helpers instead of `Thread.sleep`.

## Common mistakes
- Using real time delays in tests.
- Hardcoding dispatchers in production code, making tests harder.
- Mixing integration concerns into small unit tests.

## References
- Test coroutines on Android: https://developer.android.com/kotlin/coroutines/test
- Kotlin coroutines test guide: https://kotlinlang.org/api/kotlinx.coroutines/kotlinx-coroutines-test/
