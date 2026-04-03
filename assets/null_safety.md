# Null Safety

## Overview
Null safety in Kotlin helps reduce null-related crashes by making nullability part of the type system. It forces developers to handle missing values explicitly instead of relying on unsafe assumptions.

## What null safety means
- A non-null type like `String` cannot hold `null`.
- A nullable type like `String?` can hold either a string value or `null`.
- The compiler helps catch many null mistakes before runtime.

## Common operators
- `?.` safely calls a member only when the value is not null.
- `?:` provides a default value when the left side is null.
- `!!` forces a nullable value to be treated as non-null and can crash if the value is actually null.

## Why it matters in Android
- Android apps often work with APIs, bundles, and platform values that may be missing.
- Handling null safely improves app stability and readability.
- Compose and ViewModel code also benefit from explicit null-aware logic.

## Best practices
- Prefer non-null types unless a value can really be absent.
- Use safe calls and early returns instead of spreading `!!` through the code.
- Model optional data clearly in your domain and UI state.

## Common mistakes
- Using `!!` too often.
- Making everything nullable even when it should not be.
- Ignoring nullability when reading external input.

## Example
```kotlin
val name: String? = user.name
val displayName = name ?: "Guest"
val length = name?.length
```

## Practice

1. Convert one unsafe nullable access into a safe call or Elvis expression.
2. Review one model class and mark only truly optional fields as nullable.
3. Replace one `!!` usage with safer control flow.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Kotlin language docs: https://kotlinlang.org/docs/home.html
