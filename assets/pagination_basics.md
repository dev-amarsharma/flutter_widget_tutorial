# Pagination Basics

## Overview
Pagination is the technique of loading large datasets in smaller chunks instead of fetching everything at once. In Android apps, this improves memory usage, startup cost, and scrolling performance.

## Why paginate
- Large lists can be expensive to load all at once.
- Chunked loading reduces bandwidth and memory pressure.
- Users can start interacting with content sooner.

## Common patterns
- Page-number pagination loads page 1, page 2, and so on.
- Cursor-based pagination uses a token or key from the backend for the next batch.
- Infinite scrolling loads more data as the user approaches the end of a list.

## Android relevance
- Apps with feeds, search results, products, or logs often need pagination.
- Compose lazy lists and Paging 3 work well with paginated data.

## Best practices
- Keep loading, empty, and error states explicit.
- Avoid duplicate items when merging pages.
- Respect backend pagination rules and limits.

## Common mistakes
- Reloading the whole list unnecessarily.
- Ignoring retry behavior.
- Merging pages inconsistently.

## Example
```kotlin
suspend fun loadPage(page: Int): List<Item> {
  return api.getItems(page = page)
}
```

## Practice

1. Identify one screen in your app that would benefit from chunked loading.
2. Check whether your backend uses page numbers or cursors.
3. Design loading and retry states before wiring UI.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Kotlin language docs: https://kotlinlang.org/docs/home.html
