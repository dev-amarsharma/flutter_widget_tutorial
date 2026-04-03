# Hilt

## Overview
Hilt is Android’s recommended dependency injection library built on top of Dagger. Android Developers explains that Hilt reduces the boilerplate of manual dependency injection by generating and managing dependency containers for Android classes.

Hilt helps:

- make dependencies explicit
- manage object lifetimes
- reduce construction boilerplate
- improve testability

## Basic setup
Android’s Hilt docs require:

- applying the Hilt Gradle plugin
- adding Hilt dependencies and compiler integration
- annotating an `Application` class with `@HiltAndroidApp`

Example:

```kotlin
@HiltAndroidApp
class ExampleApplication : Application()
```

This creates the application-level Hilt container.

## Injecting Android classes
Android classes receive Hilt injection with `@AndroidEntryPoint`:

```kotlin
@AndroidEntryPoint
class MainActivity : AppCompatActivity() {
  @Inject lateinit var analytics: AnalyticsAdapter
}
```

Hilt supports Android injection for several classes including activities, fragments, services, views, and ViewModels.

## Modules
Use `@Module` and `@InstallIn(...)` when Hilt needs instructions for how to provide a type:

```kotlin
@Module
@InstallIn(SingletonComponent::class)
object NetworkModule {
  @Provides
  fun provideApi(): ApiService = TODO()
}
```

## Best practices
- Start with constructor injection whenever possible.
- Use modules only when Hilt cannot constructor-inject a type directly.
- Scope dependencies intentionally.
- Keep bindings aligned with component lifetimes.

## Common mistakes
- Using field injection where constructor injection is more appropriate.
- Installing modules in the wrong component.
- Introducing qualifiers inconsistently for multiple bindings of the same type.

## References
- Dependency injection with Hilt: https://developer.android.com/training/dependency-injection/hilt-android
- Dependency injection in Android: https://developer.android.com/training/dependency-injection
