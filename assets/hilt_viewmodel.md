# Hilt ViewModel

## Overview
Hilt integrates directly with Jetpack ViewModel. Android’s Hilt + Jetpack docs explain that you provide a ViewModel by annotating it with `@HiltViewModel` and using `@Inject` in its constructor.

Example:

```kotlin
@HiltViewModel
class ExampleViewModel @Inject constructor(
  private val savedStateHandle: SavedStateHandle,
  private val repository: ExampleRepository
) : ViewModel()
```

## Why it matters
This allows Hilt to:

- construct the ViewModel with dependencies
- integrate with the ViewModel lifecycle
- support `SavedStateHandle`
- simplify testable state-holder setup

## Scoping
Android’s docs explain that Hilt ViewModels live in `ViewModelComponent`.

Related scopes:

- `@ViewModelScoped` for a single instance shared within one ViewModel’s dependency graph
- `@ActivityRetainedScoped` to share across ViewModels tied to the same retained activity scope
- `@Singleton` for app-wide sharing

## Compose integration
Android’s Hilt Compose reference provides `hiltViewModel()` to obtain a `@HiltViewModel`-annotated ViewModel from the current `ViewModelStoreOwner`.

## Best practices
- Use `@HiltViewModel` for ViewModels managed by Hilt.
- Prefer constructor injection for repositories and saved state dependencies.
- Choose scope annotations based on the actual sharing lifetime you want.

## Common mistakes
- Confusing `@ViewModelScoped` with broader activity-retained or singleton lifetimes.
- Injecting too much unrelated logic into a single ViewModel.
- Using the wrong owner when obtaining a Hilt ViewModel in navigation-heavy apps.

## References
- Use Hilt with other Jetpack libraries: https://developer.android.com/training/dependency-injection/hilt-jetpack
- Hilt Android docs: https://developer.android.com/training/dependency-injection/hilt-android
- Compose Hilt ViewModel API: https://developer.android.com/reference/kotlin/androidx/hilt/lifecycle/viewmodel/compose/package-summary
