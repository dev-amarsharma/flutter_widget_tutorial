# Kotlin Flow Basics

## Overview
Flow represents a cold async stream of values and works naturally with coroutines.

## When to use
- In production Android apps using Kotlin/Compose stacks.
- As a foundational concept for advanced topics in the manifest path.

## Example
```kotlin
val ticker = flow {
  repeat(3) {
    emit(it)
    delay(1000)
  }
}
```

## Best practices
- Keep functions small and focused.
- Prefer readable names and explicit intent.
- Validate behavior with tests where possible.

## Common mistakes
- Skipping state/error handling.
- Mixing too many responsibilities in one layer.

## Next step
Complete the quiz file for this topic and implement a tiny sample in your project.
