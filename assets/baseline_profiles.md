# Baseline Profiles

## Overview
Baseline Profiles are an Android performance feature that helps ART optimize important code paths ahead of time. According to Android Developers, shipping a Baseline Profile can improve code execution speed by about 30% from the first launch by avoiding interpretation and some JIT work for included paths.

## What problem they solve
Without a profile, important code paths may initially run slower while the runtime gathers information and compiles hot code later. Baseline Profiles give the runtime guidance up front so startup and important interactions improve earlier.

## Benefits
Android highlights these benefits:

- faster first launch
- smoother startup
- reduced interaction jank
- runtime improvements after app updates

## How they work
Baseline Profiles are part of profile-guided optimization:

- you identify important user journeys
- generate profile rules for those code paths
- ship the profile with the app or library
- ART uses it for ahead-of-time optimization

## What to include
Good candidates include:

- app startup path
- main home screen rendering
- common navigation flows
- scrolling and repeated interactions

## Best practices
- Profile critical user journeys, not random code.
- Combine Baseline Profiles with real startup and rendering measurement.
- Keep them updated when app flows change.
- Use them alongside release-build benchmarking.

## Common mistakes
- Assuming Baseline Profiles replace measurement.
- Profiling code paths users rarely hit.
- Shipping profiles but never validating startup or jank improvements.

## References
- Baseline Profiles overview: https://developer.android.com/baseline-profiles
- App startup best practices: https://developer.android.com/topic/performance/appstartup/best-practices
