# Build a Todo App Project

## Overview
Capstone project combining Room, ViewModel, Flow/State, and Compose screens.

## When to use
- In production Android apps using Kotlin/Compose stacks.
- As a foundational concept for advanced topics in the manifest path.

## Example
```kotlin
data class Todo(val id: Int, val title: String, val done: Boolean)
// Build add/list/toggle/delete features using MVVM + Room
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
