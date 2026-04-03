# derivedStateOf

## Overview
`derivedStateOf` is a Compose API for deriving one state value from other state values when the inputs change more often than the UI actually needs to recompose. Android’s side-effects docs compare it conceptually to `distinctUntilChanged()`.

It is useful when:

- an observed value changes frequently
- the derived result changes less often
- recomposition should happen only when that derived result actually changes

## Typical use case
Android’s docs show a good example with list scroll:

```kotlin
val showButton by remember {
  derivedStateOf {
    listState.firstVisibleItemIndex > 0
  }
}
```

`firstVisibleItemIndex` may change many times while scrolling, but the UI only needs to recompose when `showButton` changes between `true` and `false`.

## Important caution
Android explicitly warns that `derivedStateOf` is expensive and should not be used by default.

It is **not** necessary when:

- the derived value should update every time the source changes
- simple string concatenation or direct calculation already matches the needed recomposition frequency

## Best practices
- Use `derivedStateOf` only to reduce unnecessary recomposition.
- Wrap it in `remember` when appropriate.
- Prefer direct expressions when the derived result should update just as often as its inputs.

## Common mistakes
- Using `derivedStateOf` for every computed value.
- Forgetting that it has overhead.
- Using it when a normal direct expression is simpler and equally correct.

## References
- Side-effects in Compose: https://developer.android.com/jetpack/compose/side-effects
- Advanced state and side effects codelab: https://developer.android.com/codelabs/jetpack-compose-advanced-state-side-effects
