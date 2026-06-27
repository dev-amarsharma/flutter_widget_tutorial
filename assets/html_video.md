# Video

## Overview
The `<video>` element embeds video content in a page.
It supports playback controls, multiple source formats, captions, and a poster image for improved user experience.

## Why this topic matters
Video is a common part of modern web content.
Using it correctly ensures compatibility, accessibility, and good performance across devices.

---

## Basic video markup
```html
<video controls width="640" height="360" poster="poster.jpg">
  <source src="sample-video.mp4" type="video/mp4">
  <source src="sample-video.webm" type="video/webm">
  Your browser does not support the video element.
</video>
```

### Important attributes
- `controls` — shows native play/pause/seek UI.
- `autoplay` — starts video automatically.
- `muted` — silences playback; required for autoplay in many browsers.
- `loop` — repeats the video.
- `poster` — image shown before playback.
- `preload` — `auto`, `metadata`, or `none` to control loading behavior.

---

## Captions and accessibility
Add captions with `<track kind="captions">` for accessibility.

```html
<video controls>
  <source src="movie.mp4" type="video/mp4">
  <track src="captions_en.vtt" kind="captions" srclang="en" label="English">
  Your browser does not support the video element.
</video>
```

---

## Multiple source support
Provide more than one format so browsers can choose a supported codec.

```html
<video controls>
  <source src="movie.mp4" type="video/mp4">
  <source src="movie.webm" type="video/webm">
</video>
```

---

## Accessibility and best practices
1. Provide a meaningful poster image if the video does not autoplay.
2. Include captions for spoken content.
3. Avoid `autoplay` unless necessary, and always pair it with `muted`.
4. Use fallback content for unsupported browsers.
5. Keep video controls visible and easy to use.

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video example</title>
  </head>
  <body>
    <h1>Watch the demo</h1>

    <video controls width="640" height="360" poster="demo-poster.jpg">
      <source src="demo.mp4" type="video/mp4">
      <source src="demo.webm" type="video/webm">
      <track src="demo-captions-en.vtt" kind="captions" srclang="en" label="English">
      Your browser does not support the video element. <a href="demo.mp4">Download the video</a>.
    </video>
  </body>
</html>
```

---

## Common mistakes to avoid
- Relying on a single video format.
- Not providing captions for spoken content.
- Using `autoplay` without considering user control.
- Forgetting fallback content for unsupported browsers.
- Omitting the `poster` image when needed.

---

## Quick practice
1. Add a `<video>` element with `controls` and two `<source>` formats.
2. Include a caption track and fallback text.
3. Use `poster` to show a preview image.
4. Avoid autoplay unless the user expects it.

---

## Official references
- MDN: `<video>` element: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/video
- WHATWG: Video element: https://html.spec.whatwg.org/multipage/media.html#the-video-element
