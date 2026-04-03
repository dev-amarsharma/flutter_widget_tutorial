# Modularization

## Overview
Modularization splits an Android app into smaller Gradle modules so features, data, and shared code can evolve independently. In Jetpack Compose projects, this improves build speed, ownership, reuse, and architectural boundaries.

## Why modularize
- Reduce build times by recompiling only changed modules.
- Keep feature code isolated and easier to maintain.
- Enable parallel development across teams or app areas.
- Reuse shared UI, domain, or data modules across multiple features.

## Common module types
- `app`: final application entry point that wires everything together.
- `feature:*`: screen-specific or user-flow-specific modules.
- `core:ui`: reusable Compose components, themes, and design system code.
- `core:data` or `data:*`: repositories, network, database, and serialization logic.
- `core:domain`: business rules, use cases, and model abstractions.

## Compose-specific benefits
- Shared composables can live in dedicated UI modules instead of being duplicated.
- Navigation destinations can be grouped by feature module.
- Previewable UI becomes easier to organize when design-system components are separated from feature logic.

## Best practices
- Keep module APIs small and stable.
- Avoid circular dependencies between modules.
- Use dependency injection or interfaces instead of direct cross-feature access.
- Start simple; do not create too many tiny modules too early.

## Common mistakes
- Splitting code into many modules without clear boundaries.
- Letting feature modules depend on one another directly.
- Putting app-specific code into shared core modules.

## Example
```kotlin
// settings.gradle.kts
include(":app")
include(":feature:home")
include(":feature:profile")
include(":core:ui")
include(":core:data")
```

## Practice

1. Identify one part of your app that can become a standalone feature module.
2. Move shared Compose UI into a reusable core module.
3. Review dependencies and remove any unnecessary cross-module coupling.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Navigation Compose guide: https://developer.android.com/jetpack/compose/navigation
