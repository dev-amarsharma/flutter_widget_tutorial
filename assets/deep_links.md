# Deep Links

## Overview
A deep link takes a user directly to a specific destination inside an app. Android Developers distinguishes between:

- explicit deep links
- implicit deep links

Explicit deep links use a `PendingIntent` to open a specific location in your app, often from notifications or widgets. Implicit deep links let the system route matching links or intents into your app based on manifest or Navigation configuration.

## Explicit vs implicit
From Android’s navigation docs:

- explicit deep link: opens a known destination in your app through a prepared intent path
- implicit deep link: matches incoming actions, URIs, or MIME types against intent filters or navigation deep-link patterns

## Back stack behavior
The Navigation docs note an important behavior for explicit deep links:

- the task back stack is cleared and replaced with the deep link destination
- start destinations from nested graphs are also added so Back behaves naturally

This matters because deep link entry should still produce sensible navigation history.

## Manifest matching
For implicit deep links, Android matches intents using:

- action
- data such as URI scheme, host, and path
- category

Manifest `<intent-filter>` and `<data>` elements define what your app can receive.

## Best practices
- Keep deep-link routes stable and predictable.
- Test both cold-start and in-app deep-link entry paths.
- Make sure Back behavior still feels natural.
- Use lowercase host names in manifest data declarations.

## Common mistakes
- Forgetting how the back stack changes for deep-link entry.
- Declaring overly broad intent filters.
- Not testing path and host matching carefully.

## References
- Create a deep link for a destination: https://developer.android.com/guide/navigation/navigation-deep-link
- Intents and intent filters: https://developer.android.com/guide/topics/intents/intents-filters
- `<data>` manifest element: https://developer.android.com/guide/topics/manifest/data-element
