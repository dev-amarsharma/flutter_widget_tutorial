# Multi-Module Architecture

## Overview
A multi-module architecture organizes an Android project into separate modules with defined responsibilities. In Compose apps, it helps structure features, shared UI, domain rules, and data layers so the project scales more cleanly.

## Architecture idea
- Each module should have a focused responsibility.
- Dependencies should point inward toward stable abstractions, not random feature-to-feature links.
- The result is better scalability, testability, and ownership.

## Typical layers
- `feature` modules expose screens and feature-specific state handling.
- `domain` modules contain business logic and use cases.
- `data` modules implement repositories, APIs, and local persistence.
- `core` modules provide shared utilities, UI components, and common models.

## Compose integration
- Feature modules can expose composable entry points for navigation.
- Shared design system code can live in a core UI module.
- State flows from data and domain layers into ViewModels and then into Compose UI.

## Dependency direction
- The app module depends on features and shared modules.
- Feature modules may depend on domain or core modules.
- Low-level modules should not depend on high-level app wiring.

## Best practices
- Define clear public APIs for each module.
- Keep models and interfaces where they create the least coupling.
- Review architecture regularly as the app grows.

## Example
```kotlin
:app
:feature:home
:feature:search
:core:ui
:core:domain
:data:network
:data:local
```

## Practice

1. Map your current app into feature, core, domain, and data responsibilities.
2. Check whether any feature module depends directly on another feature.
3. Move reusable UI and business abstractions to shared modules where appropriate.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Navigation Compose guide: https://developer.android.com/jetpack/compose/navigation
