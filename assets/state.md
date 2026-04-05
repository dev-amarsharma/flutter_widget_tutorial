# State in Compose

## Overview
State drives UI in Compose. When state changes, Compose recomposes affected UI.

## When to use
- In production Android apps using Kotlin/Compose stacks.
- As a foundational concept for advanced topics in the manifest path.

## Example
```kotlin
@Composable
fun Counter() {
  var count by remember { mutableStateOf(0) }
  Button(onClick = { count++ }) { Text("$count") }
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
