# Canvas in Compose

## Overview
`Canvas` in Compose gives you explicit drawing control. Android Developers describes it as a convenient wrapper around `Modifier.drawBehind`.

Inside a `Canvas`, you draw with a `DrawScope`, which provides drawing functions and useful properties such as `size`.

## What you can draw
Common drawing operations include:

- `drawRect`
- `drawCircle`
- `drawLine`
- `drawPath`
- `drawArc`

## Example
```kotlin
Canvas(modifier = Modifier.fillMaxSize()) {
  val half = size / 2f
  drawRect(
    color = Color.Magenta,
    size = half
  )
}
```

## DrawScope
`DrawScope` provides:

- canvas size
- current drawing environment
- helper functions for drawing primitives

Compose simplifies some of the lower-level complexity compared with view-based drawing because you do not manage `Paint` objects the same way as classic Android canvas code.

## When to use Canvas
Use `Canvas` when:

- standard composables are not enough
- you need custom graphics
- charts, custom progress indicators, or decorative visuals need exact control

## Best practices
- Use `Canvas` only when a regular composable is not expressive enough.
- Keep drawing logic focused and test visually on real screens.
- Use `DrawScope.size` rather than hardcoding dimensions when possible.

## Common mistakes
- Rebuilding custom drawing for UI that standard composables already handle well.
- Hardcoding coordinates without considering canvas size.
- Mixing layout concerns with drawing concerns.

## References
- Graphics in Compose overview: https://developer.android.com/develop/ui/compose/graphics/draw/overview
