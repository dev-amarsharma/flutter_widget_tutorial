# Checkbox and Switch

## Overview
Checkboxes and switches both represent boolean-style state, but they are not interchangeable. Android Developers gives different guidance for each:

- checkbox for selecting one or more items in a list or indicating agreement
- switch for toggling a setting or feature on and off

## Checkbox
Compose checkboxes support three states:

- unselected
- selected
- indeterminate

Checkboxes are a good fit when users can select multiple options.

## Switch
A switch toggles between checked and unchecked.

Switches are a better fit for settings and immediate on/off controls, such as:

- notifications enabled
- dark theme enabled
- sync enabled

## Example
```kotlin
var checked by remember { mutableStateOf(false) }

Checkbox(
  checked = checked,
  onCheckedChange = { checked = it }
)

Switch(
  checked = checked,
  onCheckedChange = { checked = it }
)
```

## How to choose
Use a checkbox when:

- the choice belongs in a list of selectable items
- multiple selections are allowed
- an indeterminate state may be meaningful

Use a switch when:

- the control represents a setting
- the user expects an immediate on/off state

## Best practices
- Match the component to the meaning of the choice, not just the visuals.
- Use descriptive labels.
- Keep state and label close together for accessibility and clarity.

## Common mistakes
- Using switches for multi-select lists.
- Using checkboxes for preference toggles that should read like settings.
- Omitting clear labels or surrounding click targets.

## References
- Checkbox: https://developer.android.com/develop/ui/compose/components/checkbox
- Switch: https://developer.android.com/develop/ui/compose/components/switch
