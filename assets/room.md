# Room Database Setup

## Overview
Room provides an abstraction over SQLite with compile-time query checks.

## When to use
- In production Android apps using Kotlin/Compose stacks.
- As a foundational concept for advanced topics in the manifest path.

## Example
```kotlin
@Entity data class Note(@PrimaryKey val id: Int, val text: String)
@Dao interface NoteDao { @Query("SELECT * FROM Note") suspend fun all(): List<Note> }
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
