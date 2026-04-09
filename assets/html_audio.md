# Audio

## Overview
The `<audio>` element embeds sound files directly in a web page.
It supports native playback controls, multiple source formats, and fallback content for browsers that do not support audio.

## Why this topic matters
Audio is useful for podcasts, music players, language learning, and multimedia interfaces.
Knowing how to provide accessible audio and browser-compatible formats improves the user experience.

## Core concepts
- `<audio>` is a media element that plays sound without video.
- `controls` adds built-in play/pause/seek UI.
- `src` can point to a single file, or use `<source>` tags for multiple formats.
- `autoplay`, `muted`, and `loop` control playback behavior.
- Fallback text inside `<audio>` helps unsupported browsers.

## HTML audio syntax
```html
<audio controls>
  <source src="audio-file.mp3" type="audio/mpeg">
  <source src="audio-file.ogg" type="audio/ogg">
  Your browser does not support the audio element.
</audio>
```

### Important attributes
- `controls` — shows browser playback controls.
- `autoplay` — starts playing automatically.
- `muted` — starts silent; required for autoplay in modern browsers.
- `loop` — repeats audio after it ends.
- `preload` — hints how the browser should load audio (`auto`, `metadata`, `none`).
- `controlslist` — limits which controls are visible in supported browsers.

---

## Working with multiple sources
Because browsers support different audio codecs, include more than one format.

```html
<audio controls>
  <source src="music.mp3" type="audio/mpeg">
  <source src="music.ogg" type="audio/ogg">
  Your browser does not support audio playback.
</audio>
```

---

## Accessibility and best practices
1. Provide a brief text alternative inside `<audio>` for unsupported browsers.
2. Avoid `autoplay` unless the audio is essential; it can be disruptive.
3. Use `muted` when autoplay is required and allow users to unmute.
4. Keep audio controls visible and easy to use.
5. Add captions or transcripts for spoken content when needed.

---

## Real example

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Audio Player Example</title>
  </head>
  <body>
    <h1>Listen to the audio sample</h1>

    <audio controls preload="metadata">
      <source src="sample-audio.mp3" type="audio/mpeg">
      <source src="sample-audio.ogg" type="audio/ogg">
      Your browser does not support the audio element. You can download the file instead:
      <a href="sample-audio.mp3">Download MP3</a>.
    </audio>

    <p>
      Use the controls to play, pause, and change the volume. The audio is provided in both MP3 and OGG formats so more browsers can play it.
    </p>
  </body>
</html>
```

---

## Common mistakes to avoid
- Relying on only one audio format.
- Using `autoplay` without user consent.
- Not providing fallback text for unsupported browsers.
- Forgetting to include semantic instructions for screen reader users.
- Placing important audio without captions or transcripts.

---

## Quick practice
1. Add an `<audio>` element with `controls` and two `<source>` formats.
2. Include fallback text and a download link.
3. Add `preload="metadata"` to give the browser a hint.
4. Avoid autoplay unless the audio is essential.

---

## Official references
- MDN: `<audio>` element: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio
- WHATWG: Audio element reference: https://html.spec.whatwg.org/multipage/media.html#the-audio-element
