# Compose Testing

## Overview
Android’s Compose testing docs describe Compose UI tests as a way to verify that the behavior of your Compose code is correct. Compose provides testing APIs to:

- find nodes
- perform actions
- assert properties
- manage synchronization

These APIs help catch UI bugs early and improve confidence in screen behavior.

## Core testing setup
Common dependencies and tools include:

- `ui-test-junit4`
- `ui-test-manifest` for some setups
- `createComposeRule()`
- `createAndroidComposeRule()`

Example:

```kotlin
class MyComposeTest {
  @get:Rule
  val composeTestRule = createComposeRule()

  @Test
  fun showsWelcomeMessage() {
    composeTestRule.setContent {
      Greeting("Asha")
    }

    composeTestRule.onNodeWithText("Hello Asha").assertExists()
  }
}
```

## Key concepts
Android’s docs highlight:

- semantics
- finders
- assertions
- actions
- synchronization

Semantics are especially important because tests interact with meaningful UI nodes rather than raw rendered pixels.

## Best practices
- Use semantic labels and stable text where appropriate.
- Test behavior, not implementation details.
- Cover critical flows with both unit and UI tests where needed.
- Use Compose testing APIs instead of fragile manual waits.

## Common mistakes
- Writing tests that depend on brittle implementation details.
- Ignoring semantics and accessibility labels.
- Assuming UI is ready without synchronization.
- Testing too little of critical user flows.

## References
- Test your Compose layout: https://developer.android.com/develop/ui/compose/testing
- Testing in Compose quick guide: https://developer.android.com/develop/ui/compose/quick-guides/content/video/testing-in-compose
- Compose accessibility testing: https://developer.android.com/develop/ui/compose/accessibility/testing
