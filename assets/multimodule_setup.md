# Multimodule Setup

## Overview
A multimodule setup is the practical Gradle configuration required to add and connect multiple modules in an Android project. It includes declaring modules, configuring plugins, and managing dependencies between them.

## Core setup steps
- Create the module directories and Gradle files.
- Include each module in `settings.gradle.kts`.
- Apply the correct plugins such as Android library or Kotlin Android.
- Add inter-module dependencies in the relevant `build.gradle.kts` files.

## Compose setup in library modules
- Enable Compose where the module declares composables.
- Share compiler and UI dependencies through version catalogs or convention plugins when possible.
- Use Android library modules for reusable UI or feature code.

## Dependency examples
- The app module often uses `implementation(project(":feature:home"))`.
- A feature module may depend on `:core:ui` or `:core:domain`.
- Avoid exposing more than necessary; choose `api` vs `implementation` carefully.

## Scaling tips
- Use convention plugins or build logic to reduce duplication.
- Keep namespace values and Android config consistent.
- Document the purpose of each module.

## Example
```kotlin
// settings.gradle.kts
include(":app")
include(":core:ui")
include(":feature:home")

// app/build.gradle.kts
dependencies {
  implementation(project(":feature:home"))
}
```

## Practice

1. Add one library module and connect it to your app module.
2. Move one reusable Compose widget into a shared module.
3. Review whether `api` dependencies can be reduced to `implementation`.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Navigation Compose guide: https://developer.android.com/jetpack/compose/navigation
