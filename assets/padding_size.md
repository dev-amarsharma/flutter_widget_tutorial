# Padding and Size

## Overview
In Jetpack Compose, `padding` and size modifiers are foundational layout tools used to control spacing and dimensions. They help define how much room a composable takes and how its content is positioned within or around it.

## Padding basics
- `Modifier.padding()` adds inner spacing around the content of a composable.
- You can apply uniform, horizontal/vertical, or side-specific padding values.

## Size basics
- `Modifier.size()` sets both width and height together.
- `width()`, `height()`, `fillMaxWidth()`, and `fillMaxSize()` control dimensions in different ways.
- Constraints from parents still influence final layout behavior.

## Modifier order matters
- In Compose, modifier order can change visual and layout results.
- For example, `background().padding()` behaves differently from `padding().background()`.

## Why it matters
- Good spacing improves readability and touch comfort.
- Correct sizing helps layouts adapt across screens and orientations.

## Common mistakes
- Adding hardcoded spacing inconsistently across screens.
- Ignoring modifier order.
- Overusing fixed sizes where flexible layouts would be better.

## Example
```kotlin
Box(
  modifier = Modifier
    .fillMaxWidth()
    .padding(16.dp)
    .height(56.dp)
)
```

## Practice

1. Experiment with swapping `padding` and `background` to see the difference.
2. Replace one fixed width with a more flexible layout modifier.
3. Create a small spacing system instead of repeating random dp values.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Kotlin language docs: https://kotlinlang.org/docs/home.html
