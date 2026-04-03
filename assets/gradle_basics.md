# Gradle Basics for Android

## Overview
Android apps are built with Gradle and the Android Gradle Plugin. Android Developers explains that the build system compiles source code and resources, then packages them into APKs or Android App Bundles for testing and distribution.

Gradle is task-based, and plugins contribute tasks plus configuration.

## Key pieces
Android’s build docs highlight:

- the Gradle Wrapper (`gradlew`)
- the project `settings.gradle.kts`
- module-level `build.gradle.kts` files
- `gradle.properties`
- source sets

## Build files
Common roles:

- `settings.gradle.kts`: declares included modules and some top-level repository/plugin config
- module `build.gradle.kts`: configures app or library modules
- `gradle.properties`: project-wide Gradle settings
- `gradle-wrapper.properties`: chooses the Gradle distribution version

## Android-specific build concepts
The Android build docs emphasize:

- build types
- product flavors
- build variants
- source sets

These work together to define how different app versions are built.

## Best practices
- Use the Gradle Wrapper for consistent builds.
- Keep module build configuration clear and focused.
- Understand which file owns which part of the build.
- Avoid random build logic sprawl across files.

## Common mistakes
- Editing the wrong build file for a given concern.
- Ignoring wrapper-managed version consistency.
- Mixing configuration intent across unrelated modules.

## References
- Configure your build: https://developer.android.com/build
- Gradle build overview: https://developer.android.com/studio/build/gradle-build-overview
