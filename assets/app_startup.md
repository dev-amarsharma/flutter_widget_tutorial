# App Startup

## Overview
App startup is the time from launch until users can meaningfully interact with the app. Android performance guidance treats startup as a critical first impression and recommends optimizing for cold start first, because it is typically the slowest case.

Android Developers describes three launch modes:

- cold start: the process is not in memory
- warm start: the process exists, but activity recreation is needed
- hot start: the process and activity are already in memory

## Why startup performance matters
Slow startup can:

- make users abandon the app
- hurt perceived quality
- reduce retention

Android recommends measuring rather than guessing.

## How to analyze startup
Official Android guidance recommends:

- testing release builds, not debug builds
- using Macrobenchmark for startup measurement
- capturing traces to inspect what happens during launch
- prioritizing cold startup traces

Useful metrics and tools include:

- `StartupTimingMetric`
- Perfetto or system traces
- `reportFullyDrawn()` for fully drawn timing

## Optimization strategies
Android performance docs recommend:

- defer unnecessary work from startup
- avoid many expensive content provider initializations
- use the App Startup library to consolidate initialization
- minimize large images and startup I/O
- use Baseline Profiles to improve first-launch performance

## App Startup library
The Jetpack App Startup library helps order component initialization while reducing overhead compared with many separate content providers.

## Best practices
- Measure cold startup on release builds.
- Move noncritical work later in the flow.
- Keep the main activity lean.
- Add custom traces around expensive startup code.
- Use Baseline Profiles and consider startup profiles where relevant.

## Common mistakes
- Measuring only debug builds.
- Doing network, database, or heavy object graph setup before the first screen is usable.
- Loading too many assets at startup.
- Optimizing without traces or benchmarks.

## References
- App startup time: https://developer.android.com/topic/performance/vitals/launch-time
- App startup analysis and optimization: https://developer.android.com/topic/performance/appstartup/analysis-optimization
- App startup best practices: https://developer.android.com/topic/performance/appstartup/best-practices
- App Startup library: https://developer.android.com/topic/libraries/app-startup
