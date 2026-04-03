# Buttons in Compose

## Overview
Buttons are one of the most important Material components in Compose. Android Developers describes five common button types in Material 3:

- filled
- filled tonal
- elevated
- outlined
- text

Each type has a different visual emphasis and should match the importance of the action.

## Core APIs
Common button composables:

- `Button`
- `FilledTonalButton`
- `ElevatedButton`
- `OutlinedButton`
- `TextButton`

Important parameters:

- `onClick`
- `enabled`
- `colors`
- `contentPadding`

## Example
```kotlin
Button(
  onClick = { saveProfile() },
  enabled = isFormValid
) {
  Text("Save")
}
```

## Choosing the right button
Android guidance suggests:

- filled for high-emphasis primary actions
- tonal or elevated for important but slightly softer emphasis
- outlined for medium-emphasis secondary actions
- text for low-emphasis actions

## Best practices
- Match button emphasis to action importance.
- Keep labels action-oriented and short.
- Disable actions when prerequisites are not met instead of allowing broken flows.
- Avoid placing many equally emphasized buttons together.

## Common mistakes
- Using filled buttons for every action.
- Choosing low-emphasis buttons for critical actions.
- Using vague labels like "OK" when the action can be specific.

## References
- Compose button component: https://developer.android.com/develop/ui/compose/components/button
- Material 3 in Compose: https://developer.android.com/develop/ui/compose/designsystems/material3
