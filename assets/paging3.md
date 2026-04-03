# Paging 3

## Overview
Paging 3 is Jetpack’s recommended library for loading paginated data efficiently in Android apps. It handles page requests, loading states, caching within scope, and reactive delivery to UI layers.

## What Paging 3 provides
- A structured way to request pages as needed.
- Built-in handling for loading, error, and retry states.
- Integration with Kotlin Flow, Room, and Compose.

## Core pieces
- `PagingSource` defines how a page of data is loaded.
- `Pager` configures paging behavior and produces a stream of paging data.
- UI layers collect paging data and display it incrementally.

## Compose integration
- Paging Compose helpers can collect paging items for lazy lists.
- Load states can drive loading indicators, retry UI, and empty-state decisions.

## Remote and local data
- Paging 3 can work with direct network sources or with Room-backed sources.
- RemoteMediator supports coordinated local-plus-remote paging patterns.

## Common mistakes
- Ignoring load states in the UI.
- Using unstable keys or duplicate item handling poorly.
- Skipping proper refresh and retry behavior.

## Example
```kotlin
val pager = Pager(PagingConfig(pageSize = 20)) {
  ArticlePagingSource(api)
}.flow
```

## Practice

1. Create a simple `PagingSource` for one API endpoint.
2. Expose a `Pager` flow from a repository or ViewModel.
3. Add retry UI for append and refresh failures.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Kotlin language docs: https://kotlinlang.org/docs/home.html
