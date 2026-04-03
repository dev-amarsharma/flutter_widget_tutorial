# Variables in Kotlin

## Overview
Kotlin declares variables with `val` and `var`.

- `val` declares a read-only reference. You assign it once, and you cannot reassign it later.
- `var` declares a mutable variable. You can change its value after initialization.

This is one of the first concepts you need before writing Android UI state, function parameters, data classes, and Compose state holders.

## Core rules
According to the official Kotlin syntax guide:

- A variable declaration starts with `val` or `var`, followed by the name.
- The type can be written explicitly, such as `val count: Int = 5`.
- Kotlin often infers the type, so `val count = 5` is also valid.
- If you declare a local variable without an initial value, you must specify its type before assigning it later.

## `val` vs `var`
Use `val` by default.

- `val` improves readability because the reference cannot be reassigned.
- `var` is appropriate when the value must change over time, such as a loop counter or mutable UI state.
- In Android and Compose code, preferring `val` reduces accidental reassignment and makes data flow easier to follow.

Important detail:

- `val` means the reference is read-only.
- It does not automatically make the object itself immutable.

Example:

```kotlin
val items = mutableListOf("A", "B")
items.add("C") // Valid: the list object is mutable.
// items = mutableListOf("X") // Invalid: the reference cannot be reassigned.
```

## Type inference
Kotlin can infer types from the assigned value:

```kotlin
val appName = "Compose Academy" // String
val lessonCount = 12            // Int
var progress = 0.35             // Double
```

Write the type explicitly when it improves clarity, when no initial value exists yet, or when API design should be obvious to readers.

## Initialization rules
You can initialize variables immediately:

```kotlin
val language = "Kotlin"
var completedLessons = 4
```

Or declare first and initialize later, as long as the type is explicit:

```kotlin
val totalLessons: Int
totalLessons = 20
```

Trying to use a variable before it is initialized is not allowed.

## Top-level properties
Kotlin also allows top-level properties outside classes:

```kotlin
val appVersion = "1.0"
var activeUsers = 0

fun registerUser() {
  activeUsers += 1
}
```

This is useful for constants and shared state, but mutable top-level state should be used carefully because it can make code harder to reason about.

## Android examples
Example with local variables:

```kotlin
fun formatWelcomeMessage(userName: String): String {
  val prefix = "Welcome"
  var message = "$prefix, $userName"
  message += "!"
  return message
}
```

Example in Compose:

```kotlin
@Composable
fun CounterLabel(count: Int) {
  val label = "Current count: $count"
  Text(text = label)
}
```

Here, `label` should be `val` because it is computed once in that scope and not reassigned.

## Best practices
- Prefer `val` unless you truly need reassignment.
- Use descriptive names such as `userName`, `isLoading`, or `screenTitle`.
- Rely on type inference when the type is obvious, but write the type explicitly when it makes the API easier to read.
- Keep mutable state scoped as narrowly as possible.

## Common mistakes
- Using `var` by default everywhere.
- Thinking `val` makes an entire object immutable.
- Declaring a variable without initialization and forgetting that Kotlin requires an explicit type in that case.
- Reusing the same mutable variable for unrelated purposes in a long function.

## Practice
1. Rewrite a small function using `val` everywhere possible.
2. Identify one place where `var` is still appropriate.
3. Create one example with type inference and one with an explicit type.

## References
- Kotlin official docs: https://kotlinlang.org/docs/basic-syntax.html#variables
- Android Developers: https://developer.android.com/kotlin/common-patterns
