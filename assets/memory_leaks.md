# Memory Leaks

## Overview
A memory leak happens when your app keeps references to objects that are no longer needed, preventing that memory from being reclaimed. Android's memory guidance stresses that developers still need to avoid leaks by releasing references at the right time, even though the runtime has garbage collection.

## Why leaks matter
Leaks increase memory pressure, which can lead to:

- higher RAM use
- more garbage collection work
- jank or freezes
- low memory kills on constrained devices

## Common Android causes
- long-lived references to `Context`, `Activity`, or `View`
- unnecessary running services
- callbacks, listeners, or observers that are never removed
- static references that outlive UI objects

Android's memory docs also warn that unnecessary services are one of the worst memory-management mistakes because they keep processes around and consume RAM longer than needed.

## How to reduce leaks
- clear references when lifecycle owners are destroyed
- avoid storing `Activity` or `View` in long-lived objects
- unregister listeners and callbacks
- stop services when their work is done
- use Android Studio Memory Profiler to investigate suspicious growth

## Best practices
- Prefer application context only when a longer-lived context is truly appropriate.
- Keep object lifetimes aligned with screen or feature lifetimes.
- Use profilers and heap inspection when memory keeps growing unexpectedly.

## Common mistakes
- Assuming garbage collection will fix leaked references automatically.
- Holding UI references in singletons.
- Leaving services running longer than necessary.

## References
- Manage your app's memory: https://developer.android.com/training/articles/memory
- Memory performance on Android: https://developer.android.com/topic/performance/memory
