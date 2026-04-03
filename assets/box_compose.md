# Box in Compose

## Overview
`Box` is one of the standard layout primitives in Compose. Android’s layout basics docs describe `Box` as the layout you use to place elements on top of one another.

It is useful when you need stacking behavior rather than simple horizontal or vertical placement.

## What `Box` does
`Box`:

- stacks children
- can align children inside itself
- is often used for badges, overlays, icons on images, and content over backgrounds

## Example
```kotlin
Box {
  Image(
    painter = painterResource(R.drawable.avatar),
    contentDescription = null
  )
  Icon(
    imageVector = Icons.Default.Check,
    contentDescription = "Verified",
    modifier = Modifier.align(Alignment.BottomEnd)
  )
}
```

## Alignment
You can position items with `Modifier.align(...)` for individual children or configure the box content alignment more broadly.

Typical uses:

- center content in a container
- place text over an image
- place an icon badge in a corner

## When to use `Box`
Use `Box` when:

- children need to overlap
- you want one child to fill the parent while another floats over it
- you need a simple layered layout

Use `Row` or `Column` instead when content should flow horizontally or vertically.

## Best practices
- Use `Box` for layering, not for every layout by default.
- Keep overlay layouts readable and intentional.
- Combine `Box` with alignment modifiers when placement matters.

## Common mistakes
- Using `Box` when `Row` or `Column` would better express the structure.
- Creating deeply overlapping layouts that hurt readability.
- Forgetting child alignment and assuming stacking alone controls position.

## References
- Compose layout basics: https://developer.android.com/develop/ui/compose/layouts/basics
- Layouts in Compose: https://developer.android.com/develop/ui/compose/layouts
