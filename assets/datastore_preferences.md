# Preferences DataStore

## Overview
Preferences DataStore is Android’s coroutine- and Flow-based key-value storage solution intended to replace many SharedPreferences use cases. Android’s DataStore guidance describes it as asynchronous, consistent, and transactional.

It is a good fit for:

- user settings
- filters
- sort order
- simple flags

## DataStore types
Android describes two main DataStore implementations:

- Preferences DataStore for key-value pairs
- Proto DataStore for typed objects

This topic focuses on Preferences DataStore.

## Reading data
Preferences DataStore exposes:

- `dataStore.data`, a `Flow<Preferences>`

You normally map it into a domain-specific preferences model:

```kotlin
val userPreferencesFlow: Flow<UserPreferences> = dataStore.data
  .map { preferences ->
    UserPreferences(
      showCompleted = preferences[SHOW_COMPLETED] ?: false
    )
  }
```

## Writing data
Writes are done transactionally with `edit`:

```kotlin
suspend fun updateShowCompleted(showCompleted: Boolean) {
  dataStore.edit { preferences ->
    preferences[SHOW_COMPLETED] = showCompleted
  }
}
```

Android’s docs emphasize that `edit` applies changes transactionally and asynchronously.

## Why it is better than SharedPreferences
Android highlights several benefits:

- asynchronous API
- consistency guarantees
- transactional updates
- Flow-based observation

## Best practices
- Map `Preferences` into a domain model instead of exposing raw keys everywhere.
- Use DataStore for small user preferences, not as a replacement for a relational database.
- Handle `IOException` when reading or writing.
- Keep keys centralized and named clearly.

## Common mistakes
- Exposing raw `Preferences` throughout the app.
- Treating DataStore like a full database.
- Modifying preferences outside the `edit` transform block.

## References
- Working with Preferences DataStore: https://developer.android.com/codelabs/android-preferences-datastore
- DataStore release docs: https://developer.android.com/jetpack/androidx/releases/datastore
- Preferences API reference: https://developer.android.com/reference/androidx/datastore/preferences/core/Preferences
