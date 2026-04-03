# Column in Compose

## Overview
`Column` is one of the basic layout primitives in Compose. Android’s layout basics docs present it as the layout that places children vertically.

Use it when content should flow from top to bottom.

## What Column provides
`Column`:

- arranges children vertically
- supports vertical arrangement
- supports horizontal alignment of children

## Example
```kotlin
Column(
  verticalArrangement = Arrangement.spacedBy(8.dp),
  horizontalAlignment = Alignment.Start
) {
  Text("Title")
  Text("Subtitle")
  Button(onClick = {}) {
    Text("Continue")
  }
}
```

## When to use it
Choose `Column` when:

- layout is vertical
- items should appear one below another
- a simple vertical structure is clearer than layering or custom layout

Use `Row` for horizontal arrangement and `Box` for layered overlap.

## Best practices
- Use arrangement and alignment intentionally.
- Keep simple vertical structure in `Column` rather than custom layout code.
- Prefer readability over deeply nested arbitrary layout trees.

## Common mistakes
- Using `Column` when overlap is required.
- Forgetting spacing and alignment, resulting in cluttered layout.
- Replacing simple layout needs with overly custom code.

## References
- Compose layout basics: https://developer.android.com/develop/ui/compose/layouts/basics
- Layouts in Compose: https://developer.android.com/develop/ui/compose/layouts
