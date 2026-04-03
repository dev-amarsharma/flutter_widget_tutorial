# JUnit Basics

## Overview
JUnit is the standard testing framework used in many Android local unit tests. Android's official testing docs show local unit tests written as JUnit 4 test classes and placed by default in `module-name/src/test/`.

## Basic structure
A local test class usually contains methods annotated with `@Test`:

```kotlin
class StringUtilsTest {
  @Test
  fun returnsExpectedValue() {
    assertEquals("HELLO", "HELLO")
  }
}
```

Android's docs show assertions such as `assertEquals(...)` and note that local tests are typically small and fast.

## Where local tests live
By default, Android projects place local unit tests in:

```text
module-name/src/test/
```

These run on your machine rather than on an Android device.

## What JUnit basics include
- writing test methods with `@Test`
- arranging setup data
- acting on the code under test
- asserting the expected result

## Best practices
- Keep each test focused on one behavior.
- Use descriptive test names.
- Prefer fast local tests for pure Kotlin or JVM-safe logic.
- Use instrumented tests only when Android framework behavior is required.

## Common mistakes
- Mixing many unrelated assertions in one test.
- Putting local-test-friendly logic only behind device tests.
- Writing vague test names that hide what failed.

## References
- Build local unit tests: https://developer.android.com/training/testing/local-tests
- Android testing fundamentals: https://developer.android.com/training/testing/fundamentals
