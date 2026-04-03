# Activity Lifecycle

## Overview
An Android `Activity` moves through lifecycle states as the user opens it, leaves it, returns to it, or the system reclaims resources. The platform exposes callback methods so your app can react correctly at each stage.

The official Android lifecycle guide explains that you should do the right work at the right lifecycle stage to keep apps robust, responsive, and state-safe.

## Main lifecycle callbacks
The most common callbacks are:

- `onCreate()`: perform one-time setup such as inflating UI and initializing state.
- `onStart()`: the activity becomes visible to the user.
- `onResume()`: the activity enters the foreground and the user can interact with it.
- `onPause()`: the activity is losing focus; pause lightweight ongoing work.
- `onStop()`: the activity is no longer visible.
- `onDestroy()`: final cleanup before the activity is destroyed.

Example:

```kotlin
class PlayerActivity : AppCompatActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_player)
  }

  override fun onStart() {
    super.onStart()
    // Start work tied to visibility.
  }

  override fun onStop() {
    // Release or stop work tied to visibility.
    super.onStop()
  }
}
```

## Visible and active states
Two distinctions matter a lot:

- Visible: the user can still see the activity, which usually begins at `onStart()`
- Foreground and interactive: the user can actively interact with the activity, which begins at `onResume()`

This is why some work belongs in `onStart()` and other work belongs in `onResume()`.

Examples:

- Registering UI-visible observers often fits `onStart()`
- Starting camera preview or input-sensitive work may fit `onResume()`

## What to do in each phase
Typical responsibilities:

- `onCreate()`: inflate layouts, set up adapters, create view bindings, restore simple state
- `onStart()`: begin work needed while the screen is visible
- `onResume()`: resume interaction-sensitive features
- `onPause()`: pause animations, commits, sensors, or temporary exclusive resources
- `onStop()`: stop work not needed when the UI is hidden
- `onDestroy()`: final cleanup when the activity is actually finishing or being destroyed

Do not put all setup and cleanup in one callback. Matching work to the right phase prevents bugs and wasted resources.

## State saving
Activities can be destroyed and recreated during configuration changes or process death. For short-lived UI state, Android provides `onSaveInstanceState()`.

```kotlin
override fun onSaveInstanceState(outState: Bundle) {
  super.onSaveInstanceState(outState)
  outState.putString("draft_text", currentDraft)
}
```

Use it for transient UI state such as:

- selected tab
- scroll position
- form draft text

For business data or longer-lived state, Android recommends lifecycle-aware architecture such as `ViewModel`.

## Configuration changes
A configuration change, such as device rotation, may destroy and recreate the activity. If your code assumes the activity instance always survives, you can lose UI state or duplicate work.

This is one reason modern Android apps keep screen state outside the activity when possible.

## Common Android guidance
The official Android docs emphasize:

- keep UI state resilient across recreation
- avoid holding expensive resources longer than needed
- use lifecycle-aware components
- perform cleanup when the activity stops being visible or interactive

## Best practices
- Do one-time setup in `onCreate()`.
- Start and stop work according to whether the activity is visible or interactive.
- Save transient UI state in `onSaveInstanceState()`.
- Use `ViewModel` for longer-lived screen state.
- Avoid leaking the activity by keeping long-lived references to it.

## Common mistakes
- Starting expensive work too early and not stopping it when the UI is hidden.
- Treating `onPause()` as full shutdown for everything.
- Forgetting that configuration changes can recreate the activity.
- Storing important screen state only in local fields with no restoration path.

## Practice
1. Trace what happens when an activity is opened, backgrounded, and reopened.
2. Move one resource-intensive operation from `onCreate()` to a more appropriate callback.
3. Save and restore one UI field using `onSaveInstanceState()`.

## References
- Android Developers: https://developer.android.com/guide/components/activities/activity-lifecycle
- Android app architecture: https://developer.android.com/topic/libraries/architecture/viewmodel
