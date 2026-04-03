# Moshi vs Gson

## Overview
Moshi and Gson are JSON serialization libraries often used in Android networking layers. In modern Android projects, Moshi is commonly favored for Kotlin-friendly parsing, while Gson remains widespread in older codebases and legacy integrations.

## What they do
- Convert JSON into Kotlin or Java objects.
- Serialize objects back into JSON for APIs, storage, or caching.

## Moshi highlights
- Works well with Kotlin models and adapters.
- Supports code generation for faster and safer parsing.
- Makes nullability handling more predictable in Kotlin projects.

## Gson highlights
- Very common in older Android codebases and tutorials.
- Easy to start with using reflection-based parsing.
- Useful when maintaining existing projects that already depend on Gson.

## When to choose which
- Choose Moshi for a modern Kotlin-first architecture.
- Choose Gson when working with an existing codebase that already uses it heavily.
- Prefer consistency across the project over mixing both without a reason.

## Compose note
- Compose itself does not require either library, but apps often use one in the data layer that feeds UI state.

## Example
```kotlin
@JsonClass(generateAdapter = true)
data class User(
  val id: Int,
  val name: String
)
```

## Practice

1. Inspect your network layer and identify which JSON parser it currently uses.
2. Try creating one simple model using Moshi code generation.
3. Avoid mixing Moshi and Gson unless migration or interoperability requires it.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Navigation Compose guide: https://developer.android.com/jetpack/compose/navigation
