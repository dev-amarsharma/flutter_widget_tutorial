# LaunchedEffect

## Overview
`LaunchedEffect` is a Compose side-effect API for running suspend work tied to the lifecycle of a composable. Android's official side-effects guide says it launches a coroutine when the effect enters composition and cancels that coroutine when the effect leaves composition.

## Basic usage

```kotlin
LaunchedEffect(userId) {
  viewModel.loadUser(userId)
}
```

The key controls when the effect restarts. If `userId` changes, Compose cancels the old coroutine and launches a new one.

## Why keys matter
Keys define when the effect should restart. Choose keys that represent the actual inputs of the work.

- stable key: restart only when that input changes
- `Unit` or `true`: run once for the life of that composition entry

Android's docs also warn that `LaunchedEffect(true)` should make you pause and confirm you really want a long-lived effect.

## Good use cases
- one-off data loading for a specific key
- collecting a flow in UI scope
- starting a timed animation or snackbar event
- calling suspend functions from composition-aware code

## Best practices
- Keep work UI-related.
- Choose keys deliberately.
- Avoid putting business logic directly in the composable if it belongs in a state holder.
- Prefer other side-effect APIs when they better express the job.

## Common mistakes
- Using the wrong key and restarting work unnecessarily.
- Doing unrelated business logic inside the effect.
- Treating `LaunchedEffect` as a general replacement for ViewModel scope.

## References
- Side-effects in Compose: https://developer.android.com/jetpack/compose/side-effects
