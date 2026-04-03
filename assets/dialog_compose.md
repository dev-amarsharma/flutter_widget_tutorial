# Dialogs in Compose

## Overview
Compose provides two main dialog APIs:

- `AlertDialog`
- `Dialog`

Android’s official docs explain that dialogs appear above the main app content and create an interruptive UI experience to capture user attention.

Typical use cases:

- confirming an action
- requesting input
- presenting a short set of options

## `AlertDialog`
`AlertDialog` is the convenient Material-styled API. Android documents key slots such as:

- `title`
- `text`
- `icon`
- `confirmButton`
- `dismissButton`
- `onDismissRequest`

Use it when the dialog structure matches a normal alert with actions.

## `Dialog`
`Dialog` is the lower-level container. Android’s docs note that it does not provide styling or predefined slots. You are responsible for:

- inner container such as `Card`
- size
- shape
- content layout

Use it when the dialog needs custom content such as forms, images, or more flexible layouts.

## Best practices
- Use `AlertDialog` for standard confirmation flows.
- Use `Dialog` for custom layouts or more complex content.
- Keep dialog actions clear and minimal.
- Make dismiss behavior explicit with `onDismissRequest`.

## Common mistakes
- Using a heavy custom dialog when `AlertDialog` is enough.
- Forgetting to provide an inner container and sizing for `Dialog`.
- Putting too much content into a modal interruption.

## References
- Compose dialog docs: https://developer.android.com/develop/ui/compose/components/dialog
