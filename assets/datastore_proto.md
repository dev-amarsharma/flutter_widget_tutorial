# Proto DataStore

## Overview
Proto DataStore is the typed DataStore implementation for Android. Android’s official codelab explains that DataStore is built on Kotlin coroutines and Flow and provides two implementations:

- Preferences DataStore for key-value pairs
- Proto DataStore for typed objects backed by protocol buffers

Proto DataStore is useful when you want a strongly typed schema rather than raw preference keys.

## Why use Proto DataStore
Compared with key-value preferences, Proto DataStore gives you:

- strongly typed models
- schema evolution through Protocol Buffers
- asynchronous and transactional reads and writes
- Flow-based observation

It is a good fit for structured settings such as:

- user preferences objects
- app configuration state
- nested preference groups

## How it works
Proto DataStore stores a protobuf message type and uses a `Serializer<T>` to read and write that type.

Typical setup includes:

- a `.proto` schema
- generated Kotlin or Java model code
- a `Serializer`
- a `DataStore<T>`

## Example
```kotlin
object UserPreferencesSerializer : Serializer<UserPreferences> {
  override val defaultValue: UserPreferences = UserPreferences.getDefaultInstance()

  override suspend fun readFrom(input: InputStream): UserPreferences {
    return UserPreferences.parseFrom(input)
  }

  override suspend fun writeTo(t: UserPreferences, output: OutputStream) {
    t.writeTo(output)
  }
}
```

Writes are typically done with `updateData`, which transforms the existing object into a new one.

## Best practices
- Use Proto DataStore when the stored data has structure and should be strongly typed.
- Keep schema changes compatible over time.
- Use `updateData` for transactional object updates.
- Reserve Room for relational or query-heavy data, not preference-like state.

## Common mistakes
- Choosing Proto DataStore when a simple key-value store is enough.
- Treating it like a replacement for Room.
- Ignoring schema evolution concerns.

## References
- Proto DataStore codelab: https://developer.android.com/codelabs/android-proto-datastore
- DataStore release docs: https://developer.android.com/jetpack/androidx/releases/datastore
