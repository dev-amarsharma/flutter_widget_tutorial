# MVVM Architecture

## Overview
MVVM stands for Model-View-ViewModel, a common Android architecture pattern that separates UI rendering from state management and business coordination. In Compose, MVVM works well because composables can simply render the state exposed by a ViewModel.

## Main parts
- Model represents data sources, repositories, and business logic.
- View is the UI layer, such as composables.
- ViewModel prepares screen state and handles UI events.

## Compose fit
- Composable functions read state from the ViewModel and emit UI.
- User actions are forwarded back to the ViewModel as events or callbacks.
- This keeps UI mostly declarative and easier to test.

## Typical data flow
- Repository or use case produces data.
- ViewModel transforms it into UI state.
- Compose screen displays that state.

## Benefits
- Better separation of concerns.
- Lifecycle-aware state holders.
- Easier testing of presentation logic.

## Common mistakes
- Putting too much business logic directly in composables.
- Making ViewModels depend on Android UI widgets.
- Using ViewModel as a dumping ground for unrelated logic.

## Example
```kotlin
data class ProfileUiState(val name: String = "")

class ProfileViewModel : ViewModel() {
  private val _uiState = MutableStateFlow(ProfileUiState())
  val uiState: StateFlow<ProfileUiState> = _uiState
}
```

## Practice

1. Move one screen decision from a composable into a ViewModel.
2. Define a UI state data class for one Compose screen.
3. Trace how an event travels from button click to state update.

## References
- Android Developers: https://developer.android.com
- Jetpack Compose documentation: https://developer.android.com/jetpack/compose
- Navigation Compose guide: https://developer.android.com/jetpack/compose/navigation
