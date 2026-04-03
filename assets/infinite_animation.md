# Infinite Animation

## Overview
Compose supports continuously repeating animations through `rememberInfiniteTransition()` and an `infiniteRepeatable(...)` animation spec. Android's animation quick guide uses this API for effects such as endlessly changing scale or color.

## Core API
An infinite transition owns animation values that keep updating for as long as the composable stays in composition.

Example:

```kotlin
val infiniteTransition = rememberInfiniteTransition(label = "infinite")
val color by infiniteTransition.animateColor(
  initialValue = Color.Green,
  targetValue = Color.Blue,
  animationSpec = infiniteRepeatable(
    animation = tween(1000, easing = LinearEasing),
    repeatMode = RepeatMode.Reverse
  ),
  label = "color"
)
```

## Repeat behavior
Two concepts matter most:

- `infiniteRepeatable(...)` means the animation never stops on its own
- `RepeatMode.Reverse` makes it animate back and forth instead of jumping back to the start

You can animate different types, including floats and colors.

## Good use cases
- subtle pulsing indicators
- loading or waiting states
- ambient decorative effects
- repeating emphasis cues that do not block user interaction

## Best practices
- Keep infinite motion subtle and purposeful.
- Avoid distracting or battery-heavy effects.
- Prefer finite animations for one-time state changes.
- Remove the animation when the composable leaves composition.

## Common mistakes
- Using infinite animation for every state change.
- Making the effect too fast or visually noisy.
- Forgetting that repeated animations can affect performance if overused.

## References
- Compose animation quick guide: https://developer.android.com/develop/ui/compose/animation/quick-guide
- Compose animation introduction: https://developer.android.com/develop/ui/compose/animation/introduction
