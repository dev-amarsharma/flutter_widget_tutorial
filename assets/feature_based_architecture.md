# Feature-Based Architecture

## Overview
Feature-based architecture organizes a codebase around app features instead of broad technical buckets only. Android’s modularization guidance explains that apps can be organized as separate modules that act as building blocks, such as `:feature:news` or `:feature:profile`.

This approach becomes more valuable as the codebase grows.

## Why feature-based organization helps
Android’s modularization docs highlight benefits such as:

- scalability
- ownership clarity
- reusability
- strict visibility control
- improved build times in large projects

A feature-based structure often aligns better with how product teams think about work.

## Typical structure
A feature-oriented project may include modules like:

- `:app`
- `:core:ui`
- `:core:data`
- `:feature:checkout`
- `:feature:search`
- `:feature:profile`

Each feature can own its UI, presentation logic, and feature-specific navigation boundaries.

## Relation to modularization
Feature-based architecture often uses modularization, but Android’s docs warn against:

- modules that are too fine-grained too early
- complexity that outweighs maintainability benefits

So feature modules should be introduced deliberately.

## Best practices
- Use feature boundaries that match product and ownership boundaries.
- Keep shared code in clearly named core modules.
- Avoid turning every tiny package into its own module.
- Design dependencies to stay loosely coupled.

## Common mistakes
- Over-modularizing a small app.
- Mixing unrelated features into giant shared modules.
- Creating feature modules without clear ownership or dependency rules.

## References
- Guide to Android app modularization: https://developer.android.com/topic/modularization
- Guide to app architecture: https://developer.android.com/topic/architecture
