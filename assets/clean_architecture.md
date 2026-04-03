# Clean Architecture

## Overview
Clean architecture is an approach to structuring code so responsibilities are separated and dependencies point inward toward core business logic. Android’s architecture guidance does not mandate one exact pattern, but it strongly recommends layered architecture, separation of concerns, and unidirectional data flow.

In Android projects, clean architecture usually means organizing code into at least:

- UI layer
- data layer
- optional domain layer

## Android-recommended architecture
Android Developers recommends:

- a UI layer that displays app state
- a data layer that contains business logic and exposes data
- an optional domain layer to simplify reusable business operations

This overlaps heavily with the goals of clean architecture.

## Typical dependency direction
Good dependency flow is usually:

- UI depends on domain or data abstractions
- domain depends on data abstractions, not UI
- data implements repositories and data sources

This reduces coupling and improves testability.

## Why teams use it
Benefits:

- clearer boundaries
- easier testing
- better maintainability as the app grows
- easier reasoning about state and business rules

## Best practices
- Keep UI classes focused on UI concerns.
- Avoid storing important state in Android framework entry points.
- Use repositories to hide data source details.
- Add a domain layer only when it reduces complexity or improves reuse.

## Common mistakes
- Copying a rigid architecture template without a real need.
- Splitting into many layers and modules before the app complexity justifies it.
- Letting UI and data details leak across boundaries anyway.

## References
- Guide to app architecture: https://developer.android.com/topic/architecture
- Architecture recommendations: https://developer.android.com/topic/architecture/recommendations
