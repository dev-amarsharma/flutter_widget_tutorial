# Clickable Modifier

## Overview
`Modifier.clickable` makes a composable respond to taps or clicks. Android’s Compose gesture docs emphasize that `clickable` is a high-level interaction API that also includes useful extras such as accessibility support and visual indications like ripples.

This is usually the right first choice for tap interaction before dropping down to lower-level pointer APIs.

## What `clickable` provides
Android docs highlight that `clickable`:

- reacts to taps or clicks
- supports accessibility click events
- provides visual feedback when pressed
- works with focus and hovering support in appropriate environments

## Example
```kotlin
Text(
  text = "Open details",
  modifier = Modifier.clickable(
    onClickLabel = "Open details"
  ) {
    openDetails()
  }
)
```

## When to use it
Use `clickable` when:

- the user taps an item
- the element represents a clear action
- you want standard Compose interaction behavior

Use lower-level gesture APIs like `pointerInput` only when you need custom gesture handling beyond what `clickable` provides.

## Best practices
- Prefer `clickable` for standard tap handling.
- Provide accessible labels or semantics when the action is not obvious.
- Keep the clickable area large enough to use comfortably.
- Let standard indications communicate press feedback unless you have a strong design reason not to.

## Common mistakes
- Replacing `clickable` with lower-level pointer APIs without needing the extra control.
- Making tiny elements clickable without a reasonable hit target.
- Hiding critical actions in unlabeled or ambiguous clickable surfaces.

## References
- Pointer input in Compose: https://developer.android.com/jetpack/compose/gestures
- Tap and press: https://developer.android.com/jetpack/compose/touch-input/pointer-input/tap-and-press
- Modifier clickable API: https://developer.android.com/reference/kotlin/androidx/compose/ui/Modifier#clickable
- Compose modifiers: https://developer.android.com/develop/ui/compose/modifiers
