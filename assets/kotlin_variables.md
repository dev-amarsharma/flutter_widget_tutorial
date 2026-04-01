# Variables in Kotlin

## Overview
Kotlin variables hold state using `val` (read-only) and `var` (mutable).

## When to use
- In production Android apps using Kotlin/Compose stacks.
- As a foundational concept for advanced topics in the manifest path.

## Example
```kotlin
fun main() {
  val appName = "Android Academy"
  var lessonCount = 12
  lessonCount += 1
  println("$appName: $lessonCount")
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
