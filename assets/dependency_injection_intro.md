# Dependency Injection Introduction

## Overview
Dependency injection, or DI, is a technique for providing objects to classes that need them rather than having those classes create dependencies for themselves. Android Developers highlights three major benefits:

- reusability of code
- ease of refactoring
- ease of testing

DI is especially useful as apps grow and classes depend on more collaborators such as repositories, APIs, dispatchers, and data sources.

## Basic idea
Instead of a class doing this:

```kotlin
class Car {
  private val engine = Engine()
}
```

You inject the dependency from outside:

```kotlin
class Car(
  private val engine: Engine
)
```

Now the class states what it needs through its API surface.

## Why Android recommends it
Android’s DI docs explain that manual object creation becomes harder to manage as the dependency graph grows. DI helps by:

- reducing boilerplate construction logic
- making dependencies explicit
- improving testability because fakes can be passed in

Android currently recommends Hilt as the standard DI library for Android apps, built on top of Dagger.

## Manual DI vs service locator
Android’s docs also contrast DI with service locator:

- with DI, the app injects what the class needs
- with service locator, the class asks a global source for dependencies

Service locators can hide dependencies and make testing harder.

## Best practices
- Prefer constructor injection when possible.
- Keep dependencies explicit in class constructors.
- Use a DI framework when the graph becomes large enough to justify automation.
- Avoid hidden global dependency access.

## Common mistakes
- Creating dependencies directly inside business classes.
- Using global service locators as a substitute for clear dependency boundaries.
- Introducing a DI framework without understanding the object graph first.

## References
- Dependency injection in Android: https://developer.android.com/training/dependency-injection
- Manual dependency injection: https://developer.android.com/training/dependency-injection/manual
- Dependency injection with Hilt: https://developer.android.com/training/dependency-injection/hilt-android
