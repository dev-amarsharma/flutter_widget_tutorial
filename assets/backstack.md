# Backstack

## Overview
The back stack is the navigation history managed by `NavController`. Android Developers describes it as a last-in, first-out stack of destinations the user has visited.

As users move through the app:

- `navigate()` pushes a destination onto the stack
- Back or `popBackStack()` removes the top destination

## Basic behavior
Important rules from the Android navigation docs:

- the first destination becomes the initial top of the stack
- every forward navigation usually pushes another destination
- Back pops the top destination
- when the stack is empty after a pop attempt, `popBackStack()` returns `false`

## Example
```kotlin
navController.navigate("details/42")

val popped = navController.popBackStack()
```

This pops the current destination and returns whether the pop succeeded.

## Advanced stack control
Compose Navigation also supports stack shaping operations such as:

- `popUpTo(...)`
- `inclusive = true`
- `saveState = true`
- `restoreState = true`

These are useful for flows like:

- clearing login from history after sign-in
- restoring bottom navigation tabs
- preventing duplicate destinations

## Up vs Back
Android distinguishes between:

- Back: the system/user going backward in history
- Up: app-level navigation toward the logical parent destination

In many simple apps they feel similar, but they are not conceptually identical.

## Best practices
- Understand what each navigation action adds to the stack.
- Use `popUpTo` intentionally for auth and onboarding flows.
- Test deep links and multi-step flows with the system Back button.
- Avoid accidental duplicate destinations.

## Common mistakes
- Assuming every navigation action should remain in history forever.
- Ignoring what happens when the stack becomes empty.
- Confusing Up navigation with Back history in complex flows.

## References
- Navigation and the back stack: https://developer.android.com/guide/navigation/backstack
