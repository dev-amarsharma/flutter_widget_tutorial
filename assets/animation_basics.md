# Animation Basics

## Overview
Compose animation APIs help make state changes easier to understand. Android’s animation guidance groups them into a few families:

- value-based animations such as `animate*AsState`
- visibility and content animations such as `AnimatedVisibility` and `AnimatedContent`
- size animations such as `animateContentSize()`
- transitions for animating multiple values together
- infinite transitions for repeated motion

## Why animation matters
Good motion can:

- show cause and effect
- make screen changes easier to follow
- communicate emphasis or hierarchy
- provide feedback without extra text

Bad motion can distract users or make the interface feel slow.

## Core APIs
Common starting points:

- `animate*AsState` for a single changing value
- `AnimatedVisibility` for showing and hiding content
- `AnimatedContent` for swapping content with animation
- `animateContentSize()` for smooth size changes
- `updateTransition()` when multiple values should move together

Example:

```kotlin
AnimatedVisibility(visible = expanded) {
  Text("More details")
}
```

## Choosing the right API
Use the simplest API that matches the UI behavior:

- single property: `animate*AsState`
- show or hide something: `AnimatedVisibility`
- swap content: `AnimatedContent` or `Crossfade`
- change several values together: `Transition`
- loop forever: `rememberInfiniteTransition`

## Best practices
- Animate meaningful changes, not every change.
- Keep durations and easing consistent within the screen.
- Prefer motion that explains state rather than motion that decorates randomly.
- Test animations on real devices, not only previews.

## Common mistakes
- Using continuous animations where a subtle response is enough.
- Animating too many properties at once.
- Choosing the wrong API for the job and fighting the framework.
- Ignoring reduced clarity for accessibility-sensitive flows.

## References
- Animations in Compose: https://developer.android.com/develop/ui/compose/animation/introduction
- Value-based animations: https://developer.android.com/jetpack/compose/animation/value-based
- Animation quick guide: https://developer.android.com/develop/ui/compose/quick-guides/content/video/animation-in-compose
