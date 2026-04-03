# Image in Compose

## Overview
The `Image` composable displays visual content in Jetpack Compose. Android's official Compose graphics docs recommend `Image` with `painterResource()` for local drawable resources, and they note that remote images are typically loaded through a third-party image-loading library such as Coil's `AsyncImage`.

## Loading local images
Use `painterResource()` when the image comes from app resources:

```kotlin
Image(
  painter = painterResource(id = R.drawable.dog),
  contentDescription = stringResource(id = R.string.dog_content_description)
)
```

This works for common drawable types such as bitmap drawables and vector drawables.

## Loading network images
The Android docs point out that internet image loading is usually delegated to an image-loading library because it needs networking, decoding, and caching. A common Compose option is Coil:

```kotlin
AsyncImage(
  model = "https://example.com/image.jpg",
  contentDescription = "Profile photo"
)
```

## Accessibility
`contentDescription` matters:

- provide a meaningful description for important images
- use `null` when the image is purely decorative

That lets screen readers such as TalkBack behave correctly.

## When to use `Image` vs `Icon`
- Use `Image` for photos, illustrations, banners, and general graphics.
- Use `Icon` for small symbolic graphics that follow icon tinting and sizing conventions.

## Best practices
- Prefer resource-based images for bundled assets.
- Use an image-loading library for remote images.
- Always think through accessibility.
- Keep large images optimized to avoid unnecessary memory use.

## Common mistakes
- Forgetting `contentDescription` for meaningful content.
- Loading network images manually in UI code instead of using a proper loader.
- Using `Icon` when the content is actually a general image.

## References
- Loading images in Compose: https://developer.android.com/develop/ui/compose/graphics/images/loading
- Resources in Compose: https://developer.android.com/jetpack/compose/resources
