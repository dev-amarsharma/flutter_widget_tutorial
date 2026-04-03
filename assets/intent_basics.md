# Intent Basics

## Overview
An `Intent` is a messaging object Android uses to request an action from another app component. Official Android docs distinguish between explicit intents, which name the target component directly, and implicit intents, which describe a general action and let the system find a matching component.

## Explicit intents
Use an explicit intent when you know the exact component to start, which is common inside your own app:

```kotlin
val intent = Intent(this, DetailActivity::class.java)
startActivity(intent)
```

Android recommends explicit intents when starting services for security reasons.

## Implicit intents
Implicit intents describe what you want done rather than which component should do it.

Examples include:

- opening a web page with `ACTION_VIEW`
- sharing text with `ACTION_SEND`
- asking another app to handle a location or photo

The system matches the intent against manifest-declared intent filters.

## Important intent data
An intent can contain:

- component name
- action
- data URI
- categories
- extras

Extras are commonly used to pass additional values, but Android's security guidance says to copy only the extras a receiving component expects and sanitize them when appropriate.

## Best practices
- Use explicit intents for in-app navigation.
- Use implicit intents when another capable app should handle an action.
- Use explicit intents for services.
- Validate and limit extras when forwarding intents.

## Common mistakes
- Using implicit intents for services.
- Sending extras without considering validation.
- Forgetting that components without matching intent filters cannot receive implicit intents.

## References
- Intents and intent filters: https://developer.android.com/guide/components/intents-filters
