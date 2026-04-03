# Caching Strategies

## Overview
Caching strategies determine how your app stores and reuses data so users see useful content quickly and the app behaves well when the network is slow or unavailable.

Android’s offline-first guidance recommends starting in the data layer and using a local data source as the canonical source of truth for reads.

## Offline-first perspective
Android’s official architecture guidance highlights:

- local data source
- network data source
- repository that coordinates them

In an offline-first app:

- reads should come from the local data source
- updates from network should be written locally first
- higher layers should observe the local source

## Read strategies
Common approaches:

- read local data immediately
- refresh from network when appropriate
- update local storage
- emit updated values reactively

This provides fast UI and resilience to unreliable connectivity.

## Write strategies
Android documents three write strategies:

- online-only writes
- queued writes
- lazy writes

Queued and lazy writes are especially relevant when you want the app to remain useful offline.

## Synchronization
When connectivity returns, the app may need to synchronize local and network state. Android describes:

- pull-based synchronization
- push-based synchronization
- conflict resolution strategies such as last-write-wins, depending on product needs

## Best practices
- Keep a local source of truth for important user-facing data.
- Model repositories around both local and network sources.
- Use observable reads from local storage.
- Use WorkManager for persistent background sync when appropriate.

## Common mistakes
- Reading directly from network in every screen path.
- Treating cache as an afterthought rather than a data-layer responsibility.
- Ignoring conflict resolution for offline writes.
- Failing to define whether freshness, speed, or durability is the priority.

## References
- Build an offline-first app: https://developer.android.com/topic/architecture/data-layer/offline-first
- Guide to app architecture: https://developer.android.com/topic/architecture
