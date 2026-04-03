# Fragment Basics

## Overview
A fragment represents a reusable portion of your app’s UI. Android Developers explains that a fragment:

- defines and manages its own layout
- has its own lifecycle
- can handle its own input events
- must be hosted by an activity or another fragment

Fragments are not standalone top-level app windows. They live inside host components.

## Why fragments exist
Fragments introduce modularity and reusability into activity UI. Android’s fragment docs emphasize that activities are good places for global UI structure, while fragments are better for a screen or portion of a screen.

This made fragments especially important in view-based single-activity apps and in apps using Navigation.

## Core ideas
Important fragment basics:

- a fragment has a lifecycle distinct from the host activity
- the fragment view hierarchy attaches to the host’s view hierarchy
- fragments are often used with Navigation, ViewPager2, and other Jetpack libraries

## Example
```kotlin
class ProfileFragment : Fragment(R.layout.fragment_profile)
```

This fragment uses a layout resource and participates in fragment lifecycle management.

## Best practices
- Keep fragments focused on screen or sub-screen UI concerns.
- Avoid putting too much unrelated app logic in fragment classes.
- Use them as modular UI building blocks when working in view-based apps.
- Test fragment behavior in isolation where practical.

## Common mistakes
- Treating fragments like standalone apps.
- Putting too much business logic into fragments.
- Ignoring the distinction between fragment lifecycle and view lifecycle.

## References
- Fragments: https://developer.android.com/guide/fragments
- Test navigation: https://developer.android.com/guide/navigation/navigation-testing
