# DisposableEffect

## Overview
`DisposableEffect` is a Compose side-effect API for work that requires cleanup when keys change or when the composable leaves the composition. Android’s side-effects docs describe it as the correct tool for effects that need setup and teardown.

Typical examples:

- registering a lifecycle observer
- subscribing to callbacks
- attaching and removing listeners

## How it works
When `DisposableEffect` enters the composition:

- it runs the effect block

If its keys change or it leaves the composition:

- `onDispose` runs to clean up the current effect
- then the effect may restart with the new keys

## Example
```kotlin
DisposableEffect(lifecycleOwner) {
  val observer = LifecycleEventObserver { _, event ->
    // handle lifecycle event
  }

  lifecycleOwner.lifecycle.addObserver(observer)

  onDispose {
    lifecycleOwner.lifecycle.removeObserver(observer)
  }
}
```

Android’s docs explicitly state that `DisposableEffect` must include an `onDispose` clause as the final statement.

## Best practices
- Use it when setup must be paired with cleanup.
- Include all relevant restart keys.
- Use `rememberUpdatedState` when values should update without restarting the effect.
- Keep the effect UI-related and lifecycle-aware.

## Common mistakes
- Omitting proper cleanup logic.
- Using the wrong restart keys.
- Using `DisposableEffect` when a simpler effect or direct expression would be enough.

## References
- Side-effects in Compose: https://developer.android.com/jetpack/compose/side-effects
