# API Calls

## Overview
Android apps usually perform API calls from a data or repository layer, then expose results to the UI through a `ViewModel`. The official Android coroutines guidance recommends making network work main-safe so that calling code can remain on the main thread without blocking rendering.

The core rule is simple:

- never block the main thread with network I/O

## Recommended architecture
The Android guidance shows this pattern:

- UI triggers an action from the main thread
- `ViewModel` launches a coroutine
- repository performs network work using a suspend function
- repository moves blocking I/O to `Dispatchers.IO`
- UI observes success or failure and updates state

## Example
```kotlin
class NewsRepository(
  private val api: NewsApi
) {
  suspend fun loadArticles(): List<Article> = withContext(Dispatchers.IO) {
    api.getArticles()
  }
}

class NewsViewModel(
  private val repository: NewsRepository
) : ViewModel() {
  fun refresh() {
    viewModelScope.launch {
      val articles = repository.loadArticles()
      // update UI state
    }
  }
}
```

## Why `withContext(Dispatchers.IO)` matters
Android’s coroutines docs call a function main-safe when it can be called from the main thread without blocking UI updates. Wrapping blocking network code in `withContext(Dispatchers.IO)` makes the repository safer to call from UI-driven layers.

## Error handling
Network calls can fail because of:

- no connectivity
- server errors
- bad responses
- timeouts
- parsing issues

Use structured error handling in the `ViewModel` or repository and expose a UI-friendly result rather than crashing the screen.

## Best practices
- Keep network work out of composables and activities.
- Use `viewModelScope` for UI-triggered work.
- Make repository functions `suspend` and main-safe.
- Model loading, success, and error states explicitly.
- Avoid running API calls directly on the main thread.

## Common mistakes
- Calling blocking network code from the UI thread.
- Launching unmanaged coroutines outside a clear scope.
- Mixing parsing, networking, and UI mutation in the same function.
- Ignoring cancellation when the user leaves the screen.

## References
- Kotlin coroutines on Android: https://developer.android.com/kotlin/coroutines
- Improve app performance with Kotlin coroutines: https://developer.android.com/kotlin/coroutines/coroutines-adv
