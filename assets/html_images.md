# HTML Images

## Overview
The `<img>` element displays images on a web page.
It requires a `src` attribute for the image file and should include `alt` text to describe the image for users and assistive technologies.

## Why this topic matters
Images are a core part of web design, and proper image markup improves accessibility, performance, and SEO.
Using modern image attributes helps pages load faster and behave consistently across devices.

## Core concepts
- `src` specifies the image source URL.
- `alt` provides alternative text for screen readers and browsers that cannot display the image.
- `width` and `height` reserve layout space and prevent layout shifts.
- `loading="lazy"` defers off-screen image loading.
- `srcset` and `sizes` support responsive images.

---

## Basic image markup
```html
<img src="profile.jpg" alt="Photo of a smiling developer" width="240" height="240">
```

### Important image attributes
- `src` — required image file location.
- `alt` — required for meaningful images; use `alt=""` for decorative images.
- `width` and `height` — set the image dimensions.
- `loading` — `lazy` or `eager` to control loading behavior.
- `srcset` / `sizes` — supply multiple image sources for different screen sizes.

---

## Responsive images
Use `srcset` with `w` descriptors to provide alternate image sizes.

```html
<img
  src="photo-400.jpg"
  srcset="photo-400.jpg 400w, photo-800.jpg 800w, photo-1200.jpg 1200w"
  sizes="(max-width: 600px) 100vw, 600px"
  alt="City skyline at sunset"
  loading="lazy"
>
```

---

## Accessibility and best practices
1. Provide meaningful `alt` text that describes the image purpose.
2. Use `alt=""` for purely decorative images.
3. Include `width` and `height` to prevent layout shifts.
4. Prefer semantic HTML like `<figure>` and `<figcaption>` for illustrative content.
5. Avoid relying on images for critical text or navigation.

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Image example</title>
  </head>
  <body>
    <h1>Gallery preview</h1>

    <figure>
      <img
        src="mountains-800.jpg"
        srcset="mountains-400.jpg 400w, mountains-800.jpg 800w, mountains-1200.jpg 1200w"
        sizes="(max-width: 640px) 100vw, 640px"
        alt="Mountain landscape with a lake at sunrise"
        loading="lazy"
        width="800"
        height="533"
      >
      <figcaption>Sunrise over the mountains.</figcaption>
    </figure>
  </body>
</html>
```

---

## Common mistakes to avoid
- Leaving out the `alt` attribute for meaningful images.
- Using `alt` text that is too generic, like "image" or "photo".
- Omitting `width` and `height` attributes.
- Using images for text that should be written in HTML.
- Loading large images without responsive sources or lazy loading.

---

## Quick practice
1. Add an image with `src`, `alt`, `width`, and `height`.
2. Create a responsive image using `srcset` and `sizes`.
3. Add a `<figure>` and `<figcaption>` for a captioned photo.
4. Use `loading="lazy"` for below-the-fold images.

---

## Official references
- MDN: `<img>` element: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/img
- MDN: Responsive images: https://developer.mozilla.org/en-US/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images
