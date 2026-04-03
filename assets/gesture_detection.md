# Gesture Detection in Compose

## Overview
Compose provides several abstraction levels for gesture handling. Android’s gesture docs explain that the framework distinguishes between:

- pointers
- pointer events
- gestures

And it offers APIs ranging from high-level gesture handlers to low-level pointer input.

## Abstraction levels
Android recommends using the highest abstraction level that fits the problem:

- high-level modifiers like `clickable`
- more flexible gesture detectors such as `detectTapGestures` and `detectDragGestures`
- low-level pointer input handling when needed

High-level APIs often include useful extras like accessibility support and visual indication.

## Example
```kotlin
Modifier.pointerInput(Unit) {
  detectTapGestures(
    onTap = { offset ->
      println("Tapped at $offset")
    }
  )
}
```

## Event propagation
Android’s docs also discuss event consumption and propagation. This matters when multiple parts of the UI may respond to the same gesture stream.

## Best practices
- Start with high-level APIs like `clickable` when they fit.
- Drop to `pointerInput` only when custom gesture behavior is required.
- Test gesture behavior for touch, stylus, mouse, or trackpad if relevant to your UI.

## Common mistakes
- Replacing high-level APIs with lower-level pointer code without a real need.
- Ignoring propagation and consumption behavior.
- Building gesture logic that is hard to discover or use.

## References
- Understand gestures: https://developer.android.com/develop/ui/compose/touch-input/pointer-input/understand-gestures
- Pointer input in Compose: https://developer.android.com/develop/ui/compose/touch-input/pointer-input
