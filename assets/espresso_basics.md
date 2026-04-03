# Espresso Basics

## Overview
Espresso is Android’s UI testing framework for view-based Android UIs. Android Developers describes Espresso as a way to write concise, reliable UI tests with a small and predictable core API.

Espresso tests usually express:

- a view matcher
- an interaction
- an assertion

## Core pattern
Typical Espresso flow:

```kotlin
onView(withId(R.id.name_field)).perform(typeText("Steve"))
onView(withId(R.id.greet_button)).perform(click())
onView(withText("Hello Steve!")).check(matches(isDisplayed()))
```

This reads clearly:

- find a view
- perform an action
- assert the expected result

## Synchronization
One major Espresso benefit is synchronization. Android’s docs explain that Espresso waits until the app is idle before running actions and assertions, which reduces the need for manual sleeps and polling.

For background work outside built-in synchronization, Espresso supports idling resources.

## Packages
Important packages include:

- `espresso-core`
- `espresso-intents`
- `espresso-contrib`
- `espresso-idling-resource`

## Best practices
- Write tests in terms of user-visible behavior.
- Prefer stable matchers and clear assertions.
- Use idling resources for custom asynchronous work.
- Avoid brittle timing-based waits.

## Common mistakes
- Relying on `Thread.sleep`.
- Writing tests around internal implementation details instead of UI behavior.
- Using weak or ambiguous view matchers.

## References
- Espresso: https://developer.android.com/training/testing/espresso
