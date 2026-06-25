# Colors & Backgrounds

## Overview
CSS offers multiple formats for expressing color, from human-readable names to precise hexadecimal codes and functional notations like `rgb()` and `hsl()`. Background properties let you fill elements with colors, images, and gradients to create rich visual designs.

---

## Why this topic matters
Color and background choices define the visual identity of a site. Understanding the different formats and when to use each gives you flexibility in design systems and theming.

## Color formats

```css
.examples {
  /* Named color */
  color: tomato;

  /* Hex — #RRGGBB */
  color: #3498db;

  /* Hex short form — #RGB (same as #336699) */
  color: #369;

  /* Hex with alpha — #RRGGBBAA */
  color: #3498dbcc;

  /* RGB */
  color: rgb(52, 152, 219);

  /* RGBA — with alpha transparency (0=transparent, 1=opaque) */
  color: rgba(52, 152, 219, 0.5);

  /* HSL — hue(0-360), saturation(%), lightness(%) */
  color: hsl(204, 70%, 53%);

  /* HSLA — with alpha */
  color: hsla(204, 70%, 53%, 0.8);
}
```

### Key parts
- **Named** — 140+ keywords (e.g., `coral`, `steelblue`) — readable but limited
- **Hex** — most common in design tools; `#RRGGBB` each pair is 0–255 in base-16
- **RGB/RGBA** — functional; alpha (0–1) controls transparency
- **HSL/HSLA** — intuitive for color adjustments; hue is the color wheel angle

---

## background-color
```css
.banner {
  background-color: #2c3e50;    /* solid color */
}

.overlay {
  background-color: rgba(0, 0, 0, 0.4); /* semi-transparent black */
}
```

---

## background-image
```css
.hero {
  background-image: url('images/hero.jpg');
  background-size: cover;       /* scale to fill, may crop */
  background-position: center;  /* anchor point */
  background-repeat: no-repeat; /* don't tile */
}
```

### Background shorthand
```css
.hero {
  background: url('images/hero.jpg') center/cover no-repeat;
}
```

---

## Gradients
```css
/* Linear gradient — top to bottom by default */
.gradient-box {
  background: linear-gradient(to right, #e74c3c, #3498db);
}

/* Diagonal */
.diagonal {
  background: linear-gradient(135deg, #f39c12, #8e44ad);
}

/* Radial gradient */
.radial {
  background: radial-gradient(circle, #fff 0%, #ccc 100%);
}

/* Multiple color stops */
.stripe {
  background: linear-gradient(to right, red 0%, red 50%, blue 50%, blue 100%);
}
```

---

## Common mistakes to avoid
- Confusing `color` (text) with `background-color` (element fill)
- Using too low contrast between text color and background (accessibility issue)
- Forgetting `background-repeat: no-repeat` when using an image
- Hex values are case-insensitive (`#fff` = `#FFF`) but be consistent for readability

---

## Quick practice
1. Create three `<div>` elements styled with `background-color` using hex, rgb, and hsl respectively
2. Add a fourth div with a `linear-gradient` from two brand colors
3. Use `rgba` to add a semi-transparent overlay on top of an image background
4. Try `background-size: cover` vs `contain` and observe the difference
5. Use browser DevTools to pick colors and convert between formats

---

## Official references
- MDN: CSS color values: https://developer.mozilla.org/en-US/docs/Web/CSS/color_value
- MDN: background: https://developer.mozilla.org/en-US/docs/Web/CSS/background
- MDN: gradient: https://developer.mozilla.org/en-US/docs/Web/CSS/gradient
