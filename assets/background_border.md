# Background Border

## Overview
In Compose, visual decoration is usually added with modifiers. Two of the most common are:

- `Modifier.background(...)`
- `Modifier.border(...)`

Android’s Compose modifier docs describe modifiers as a way to decorate or augment a composable’s appearance, behavior, and layout.

## Background
`Modifier.background()` draws color or brush behind the content.

Example:

```kotlin
Text(
  text = "Hello",
  modifier = Modifier
    .background(Color.Yellow)
    .padding(8.dp)
)
```

You can also pass a shape:

```kotlin
Modifier.background(
  color = Color(0xFFE3F2FD),
  shape = RoundedCornerShape(12.dp)
)
```

## Border
`Modifier.border()` draws a border around the composable and can also take a shape.

```kotlin
Modifier.border(
  width = 2.dp,
  color = Color.Blue,
  shape = RoundedCornerShape(12.dp)
)
```

## Modifier order matters
Compose modifiers are applied in order. This means:

- `background().padding()` is different from `padding().background()`
- border and clipping effects depend on where the modifier sits in the chain

Common pattern:

```kotlin
Modifier
  .background(Color.White, RoundedCornerShape(12.dp))
  .border(1.dp, Color.Gray, RoundedCornerShape(12.dp))
  .padding(16.dp)
```

## Best practices
- Use the same shape for background and border when you want aligned edges.
- Remember that modifier order affects the final result.
- Use `Brush` backgrounds when gradients are appropriate.
- Prefer readable chains over long, random modifier stacks.

## Common mistakes
- Forgetting that modifier order changes layout and drawing behavior.
- Using mismatched shapes for background and border.
- Adding decoration without enough padding, making content look cramped.

## References
- Compose modifiers guide: https://developer.android.com/develop/ui/compose/modifiers
- Compose modifiers list: https://developer.android.com/jetpack/compose/modifiers-list
