# Battery Optimization

## Overview
Battery optimization means designing your app so it does useful work without waking the device, using the CPU, radio, sensors, or graphics pipeline more than necessary. Android’s performance and vitals docs treat battery efficiency as part of overall app quality.

## Why it matters
Poor battery behavior can:

- frustrate users
- reduce session length
- trigger Android vitals warnings in some cases
- hurt Play visibility for bad behavior thresholds

Android vitals specifically highlights excessive partial wake locks as a core quality concern for apps.

## Common battery drains
Battery problems often come from:

- excessive wake locks
- frequent background network usage
- too many wakeups or alarms
- long-running background work
- unnecessary polling
- heavy animations or rendering loops

## System behavior
Android can defer or limit background work depending on device state and app state. Resource limits and standby buckets affect how often background jobs, alarms, and other work can run.

This means efficient apps:

- batch background work
- avoid waking the device unnecessarily
- use appropriate scheduling APIs such as WorkManager

## Best practices
- Prefer WorkManager or system-scheduled work over custom polling loops.
- Release wake locks as soon as possible.
- Minimize unnecessary background network traffic.
- Avoid running high-frequency work when the user gets no benefit.
- Monitor Android vitals for battery-related quality issues.

## Common mistakes
- Holding partial wake locks longer than needed.
- Scheduling too many exact alarms or frequent background jobs.
- Polling servers repeatedly instead of reacting to real triggers.
- Treating battery optimization as only a Wear OS concern.

## References
- Android vitals overview: https://developer.android.com/topic/performance/vitals/index.html
- Power management resource limits: https://developer.android.com/topic/performance/power/power-details
- Excessive battery usage: https://developer.android.com/topic/performance/vitals/excessive-battery-usage
