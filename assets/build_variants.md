# Build Variants

## Overview
Android build variants let you create multiple versions of an app from one project. Android Developers explains that build variants are created from combinations of build types and product flavors.

Examples:

- `debug` and `release` build types
- `demo` and `full` product flavors
- combined variants such as `demoDebug` and `fullRelease`

## Core concepts
Build type:

- controls build and packaging behavior
- examples: debugability, signing, minification

Product flavor:

- represents a version of the app with different code, resources, or settings
- examples: free vs paid, min API segments, environment-specific builds

Build variant:

- the final combination Gradle builds

## Example
```kotlin
android {
  buildTypes {
    getByName("debug") {
      applicationIdSuffix = ".debug"
    }
    create("staging") {
      initWith(getByName("debug"))
    }
  }
}
```

## Source sets
Android Gradle merges source sets from:

- `main/`
- build type directories
- flavor directories
- flavor combination directories when configured

This gives you targeted code and resources per variant.

## Best practices
- Keep build types focused on build behavior.
- Use product flavors for app differences that users or environments actually need.
- Keep the variant matrix manageable.
- Document naming conventions clearly.

## Common mistakes
- Creating too many variants without a real reason.
- Mixing environment logic into UI code instead of flavor or config boundaries.
- Forgetting how source set priority and merging work.

## References
- Configure build variants: https://developer.android.com/build/build-variants
