# JSON Parsing

## Overview
JSON parsing is the process of converting JSON text into runtime objects and vice versa. Kotlin's serialization docs describe serialization as converting application data into a transferable format, and deserialization as reading external data back into runtime objects.

## Kotlin serialization approach
The official Kotlin docs describe `kotlinx.serialization` as Kotlin's serialization component. For JSON, the common workflow is:

1. Mark the model with `@Serializable`
2. Use `Json.encodeToString(...)` to serialize
3. Use `Json.decodeFromString(...)` to deserialize

Example:

```kotlin
@Serializable
data class User(val id: Int, val name: String)

val json = Json.encodeToString(User(1, "Asha"))
val user = Json.decodeFromString<User>("""{"id":1,"name":"Asha"}""")
```

## Why it matters on Android
Apps often parse JSON for:

- network responses
- cached payloads
- local files
- data exchange with APIs

## Best practices
- Model JSON with clear data classes.
- Prefer a structured parser instead of manual string handling.
- Keep field names aligned with the expected payload.
- Validate assumptions when parsing untrusted or changing data.

## Common mistakes
- Parsing JSON manually with brittle string operations.
- Using models that do not match the payload structure.
- Assuming external JSON is always valid and complete.

## References
- Kotlin serialization: https://kotlinlang.org/docs/serialization.html
