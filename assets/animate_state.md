# Animate State

## Overview
In Jetpack Compose, `animate*AsState` APIs are the simplest way to animate a single value when state changes. Android’s Compose animation docs describe them as straightforward, fire-and-forget APIs: you provide a target value, and Compose animates from the current value to the new one.

These APIs are ideal when you want to animate one property such as:

- alpha
- color
- size
- offset
- elevation

## Common APIs
Examples include:

- `animateFloatAsState()`
- `animateColorAsState()`
- `animateDpAsState()`
- `animateIntAsState()`
- `animateOffsetAsState()`

## Example
```kotlin
@Composable
fun FadingBox(enabled: Boolean) {
  val alpha by animateFloatAsState(
    targetValue = if (enabled) 1f else 0.5f,
    label = "boxAlpha"
  )

  Box(
    Modifier.graphicsLayer { this.alpha = alpha }
  )
}
```

When `enabled` changes, the alpha animates automatically.

## When to use it
Use `animate*AsState` when:

- one value changes based on state
- you do not need to manually control play, pause, or multiple coordinated values
- a simple animation improves feedback or clarity

If multiple values must change together, Android recommends moving to `Transition` APIs.

## Customizing behavior
You can pass an `animationSpec` to control motion:

- `tween()` for duration and easing
- `spring()` for natural spring motion
- `keyframes()` for timed steps

Example:

```kotlin
val size by animateDpAsState(
  targetValue = if (expanded) 120.dp else 72.dp,
  animationSpec = spring(),
  label = "cardSize"
)
```

## Best practices
- Use a descriptive `label` to improve tooling and debugging.
- Keep state as the source of truth and derive animation values from it.
- Use `animate*AsState` for one property at a time.
- Escalate to `Transition` when several values must stay coordinated.

## Common mistakes
- Using `animate*AsState` for complex multi-value choreography.
- Hiding unclear state transitions behind animation.
- Forgetting that the animation reacts to state changes rather than imperative commands.

## References
- Value-based animations: https://developer.android.com/jetpack/compose/animation/value-based
- Animations in Compose: https://developer.android.com/develop/ui/compose/animation/introduction
