# Offline-First

## Overview
Offline-first is an app design approach where the local data source is treated as the primary source for UI reads, while network data syncs in the background when available. This leads to more resilient and responsive Android apps.

## Core idea
- Read data from local storage such as Room or DataStore whenever possible.
- Sync remote updates into local storage instead of making the UI depend directly on every network request.
- Let the UI observe local data reactively.

## Why it helps
- Users can still see useful content with weak or missing connectivity.
- The UI feels faster because local reads are often immediate.
- State becomes easier to reason about when one local source feeds the screen.

## Typical flow
- Fetch from network when appropriate.
- Store fresh data in the local database.
- Expose database streams to ViewModel and UI.

## Android tools
- Room is commonly used for structured local persistence.
- WorkManager can help with background sync and retry.
- Repositories coordinate local and remote sources.

## Common mistakes
- Letting the UI depend directly on unstable network calls.
- Ignoring sync conflicts or stale-data rules.
- Skipping clear loading and error states.

## Example
```kotlin
fun observeArticles(): Flow<List<Article>> = articleDao.observeAll()

suspend fun refreshArticles() {
  val remote = api.getArticles()
  articleDao.replaceAll(remote)
}
```

## Practice

1. Identify one screen that could read from Room instead of directly from the network.
2. Define when your repository should refresh local data.
3. Add one stale-data or sync-status indicator to the UI.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Kotlin language docs: https://kotlinlang.org/docs/home.html
