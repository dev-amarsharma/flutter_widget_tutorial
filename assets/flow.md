# Flow

## Overview
Kotlin Flow is an asynchronous stream type for emitting multiple values over time. The official Kotlin docs position Flow as the answer to a common question: if a suspending function returns one asynchronous value, how do we model many asynchronously produced values? Flow is the answer.

## Key characteristics
From Kotlin docs:

- Flow emits multiple values over time
- flows are cold by default
- operators are lazy and usually return new flows quickly
- collection is sequential unless special operators change that behavior

## Cold streams
“Cold” means the code inside a flow builder does not run until the flow is collected.

Example:

```kotlin
fun simple(): Flow<Int> = flow {
  println("Flow started")
  for (i in 1..3) {
    delay(100)
    emit(i)
  }
}
```

Every new collection starts the flow again.

## Operators
Flow supports:

- intermediate operators such as `map`, `filter`, and `transform`
- terminal operators such as `collect`, `toList`, `first`, `reduce`

Intermediate operators define the pipeline. Terminal operators actually start collection.

## Best practices
- Model multi-value async streams with Flow.
- Keep business streams in repositories or state holders.
- Remember that a flow does nothing until collected.
- Be explicit about terminal operators in UI or business logic.

## Common mistakes
- Assuming a flow starts eagerly.
- Confusing a flow definition with a collected result.
- Forgetting collection context matters.

## References
- Kotlin Flow: https://kotlinlang.org/docs/flow.html
