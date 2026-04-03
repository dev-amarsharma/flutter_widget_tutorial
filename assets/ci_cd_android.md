# CI/CD for Android

## Overview
Continuous Integration means developers frequently merge code changes and automated builds and tests run afterward. Android Developers describes CI as a way to keep the repository healthy and catch problems before or soon after merge.

For Android, CI often includes:

- build verification
- lint or style checks
- host-side unit tests
- instrumented tests on emulators or device farms

## CI vs CD
CI:

- validates code continuously with automation

CD:

- extends automation into delivery or deployment workflows
- might prepare artifacts, sign builds, or ship to testing or release channels

## Android-specific automation
Android’s CI guidance calls out several useful automation layers:

- build from scratch
- local JVM tests
- lint and static analysis
- instrumented tests
- performance regression tests when appropriate

Instrumented tests can run via:

- Gradle Managed Devices
- emulators in CI
- device farms such as Firebase Test Lab

## Best practices
- Run build and unit tests on every change set.
- Add lint or static analysis early.
- Keep instrumented tests reliable and focused.
- Use scheduled runs for heavier performance suites.

## Common mistakes
- Treating CI as build-only and skipping tests.
- Relying entirely on manual release verification.
- Running unstable device tests without isolation or strategy.
- Avoiding automation for performance-sensitive flows.

## References
- Continuous Integration basics: https://developer.android.com/training/testing/continuous-integration
- Types of CI automation: https://developer.android.com/training/testing/continuous-integration/automation
