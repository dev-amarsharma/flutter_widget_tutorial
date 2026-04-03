# DrawScope

## Overview
`DrawScope` is the drawing environment used by Compose drawing APIs such as `Canvas`. Android’s graphics docs explain that drawing in Compose happens inside a drawing scope that provides both the available size and primitive drawing operations.

Inside a `DrawScope`, you can call functions like:

- `drawRect`
- `drawCircle`
- `drawLine`
- `drawArc`
- `drawPath`

## Why it matters
`DrawScope` provides the local coordinate space and helpers you need to create custom graphics without dealing directly with all the lower-level view drawing APIs.

It exposes useful information such as:

- `size`
- density-aware dimensions
- the coordinate space of the current draw call

## Example
```kotlin
Canvas(modifier = Modifier.fillMaxSize()) {
  drawCircle(
    color = Color.Blue,
    radius = size.minDimension / 4f
  )
}
```

The `size` property comes from `DrawScope` and reflects the current drawing bounds.

## Best practices
- Base drawing on the available `size` rather than magic numbers when possible.
- Keep drawing logic separated from business logic.
- Use standard composables first; reach for custom drawing only when necessary.

## Common mistakes
- Hardcoding coordinates that fail on different sizes.
- Treating drawing code as layout code.
- Reimplementing standard UI visuals with custom drawing without a real need.

## References
- Compose graphics draw overview: https://developer.android.com/develop/ui/compose/graphics/draw/overview
