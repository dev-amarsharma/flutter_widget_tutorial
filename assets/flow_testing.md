# Flow Testing

## Overview
Testing Flow-based code usually means verifying emissions, timing, completion, and error behavior. Kotlin’s Flow docs explain how collection works, and Android’s coroutine testing guidance helps make those tests deterministic with `runTest`.

In practice, Flow tests often check:

- the sequence of emitted values
- whether the flow completes
- how errors are handled
- whether operators transform values correctly

## Basic pattern
One straightforward approach is to collect a finite flow into a list:

```kotlin
@Test
fun emitsExpectedValues() = runTest {
  val result = flowOf(1, 2, 3).toList()
  assertEquals(listOf(1, 2, 3), result)
}
```

## Why coroutine test tools matter
When flows involve delays or coroutine scheduling, `runTest` and test dispatchers help:

- avoid real waiting
- control virtual time
- keep assertions deterministic

## What to test
Useful Flow tests include:

- emitted value order
- mapping and filtering output
- fallback/error behavior
- cancellation-sensitive logic

## Best practices
- Test finite flows with collection helpers like `toList()` when appropriate.
- Use `runTest` for suspending flow tests.
- Inject dependencies and dispatchers so streams are easier to control.
- Keep unit tests focused on stream behavior, not networking or database plumbing.

## Common mistakes
- Using real time sleeps for delay-based flows.
- Testing too much infrastructure in a unit test.
- Ignoring completion or error cases.

## References
- Kotlin Flow: https://kotlinlang.org/docs/flow.html
- Test coroutines on Android: https://developer.android.com/kotlin/coroutines/test
