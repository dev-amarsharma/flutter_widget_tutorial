# graphicsLayer

## Overview
`Modifier.graphicsLayer` applies graphics-layer behavior to a composable. Android’s graphics modifier docs explain that it causes the composable’s drawing instructions to render into a draw layer.

That layer enables:

- drawing isolation
- transformations
- optional rasterization for composition

## What it is used for
`graphicsLayer` is useful when you want to apply transformations to all drawing instructions for a composable, such as:

- scale
- rotation
- translation
- alpha

Example:

```kotlin
Modifier.graphicsLayer {
  rotationZ = 15f
  alpha = 0.8f
}
```

## Why layers matter
Android notes that a layer can improve how repeated drawing operations are handled because the rendering pipeline can reissue the captured drawing work efficiently. But when rasterized, transforms like scaling may behave more like bitmap transformations.

## Best practices
- Use `graphicsLayer` when you need whole-composable transforms or layer isolation.
- Prefer simpler modifiers when a full graphics layer is not necessary.
- Test visual quality when scaling or rotating rasterized content.

## Common mistakes
- Reaching for `graphicsLayer` when simpler layout or draw modifiers would do.
- Forgetting that layer behavior may affect rendering characteristics under transforms.
- Overusing graphics layers without a visual or performance reason.

## References
- Graphics modifiers: https://developer.android.com/develop/ui/compose/graphics/draw/modifiers
