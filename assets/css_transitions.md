# Transitions & Animations

## Overview
CSS transitions and animations bring interfaces to life. Transitions smoothly interpolate between two style states (like a hover effect), while `@keyframes` animations let you define multi-step sequences that run automatically. Both use timing functions to control the feel of movement.

---

## Why this topic matters
Subtle, well-timed animations improve perceived performance and usability. They provide visual feedback (button press, loading states) and guide users' attention — without requiring JavaScript.

## CSS Transitions
```css
.button {
  background: steelblue;
  color: white;
  padding: 10px 20px;
  border-radius: 4px;

  /* transition: property duration timing-function delay */
  transition: background 0.3s ease, transform 0.2s ease;
}

.button:hover {
  background: darkblue;
  transform: scale(1.05);
}
```

### transition shorthand breakdown
```
transition: <property> <duration> <timing-function> <delay>
```
- **property** — which property to animate (`all` for everything)
- **duration** — how long (e.g., `0.3s`, `300ms`)
- **timing-function** — speed curve (see below)
- **delay** — wait before starting (optional, default `0s`)

---

## Timing functions
```css
.box {
  transition: transform 0.4s ease;         /* slow start, fast middle, slow end */
  transition: transform 0.4s linear;       /* constant speed */
  transition: transform 0.4s ease-in;      /* slow start */
  transition: transform 0.4s ease-out;     /* slow end */
  transition: transform 0.4s ease-in-out;  /* slow start and end */
  transition: transform 0.4s cubic-bezier(0.34, 1.56, 0.64, 1); /* custom bounce */
}
```

---

## @keyframes animations
```css
@keyframes slideIn {
  from {
    transform: translateX(-100%);
    opacity: 0;
  }
  to {
    transform: translateX(0);
    opacity: 1;
  }
}

.panel {
  animation: slideIn 0.5s ease-out forwards;
}
```

### Multi-step keyframes
```css
@keyframes pulse {
  0%   { transform: scale(1); }
  50%  { transform: scale(1.1); }
  100% { transform: scale(1); }
}
```

---

## animation shorthand
```css
.element {
  /* name duration timing-function delay iteration-count direction fill-mode */
  animation: pulse 1s ease-in-out 0s infinite normal none;

  /* Short forms */
  animation: pulse 1s ease infinite;     /* loops forever */
  animation: fadeIn 0.5s ease forwards;  /* runs once, keeps end state */
}
```

### Key animation properties
- **iteration-count** — `1`, `3`, `infinite`
- **direction** — `normal`, `reverse`, `alternate`, `alternate-reverse`
- **fill-mode** — `none`, `forwards` (stay at end), `backwards`, `both`

---

## transform property (used in transitions and animations)
```css
.box {
  transform: translateX(50px);      /* move right 50px */
  transform: translateY(-20px);     /* move up 20px */
  transform: scale(1.5);            /* grow 150% */
  transform: rotate(45deg);         /* rotate 45 degrees */
  transform: skewX(10deg);          /* skew horizontally */

  /* Combine multiple transforms */
  transform: translateX(20px) rotate(10deg) scale(1.1);
}
```

---

## Common mistakes to avoid
- Transitioning `width` or `height` (expensive for performance — prefer `transform` and `opacity`)
- Using `transition: all` (can cause unexpected transitions on properties you don't want)
- Forgetting `forwards` fill-mode when you want the animation to stay at its end state
- Animating too many properties at once (hurts performance on mobile)

---

## Quick practice
1. Add a `transition: background 0.3s ease` on a button and change its `background` on `:hover`
2. Write a `@keyframes fadeIn` animation from `opacity: 0` to `opacity: 1`
3. Apply it with `animation: fadeIn 0.8s ease forwards` on a card component
4. Create a loading spinner using `@keyframes spin` with `transform: rotate(360deg)`
5. Experiment with `cubic-bezier` in DevTools to create a bouncy easing

---

## Official references
- MDN: transition: https://developer.mozilla.org/en-US/docs/Web/CSS/transition
- MDN: animation: https://developer.mozilla.org/en-US/docs/Web/CSS/animation
- MDN: @keyframes: https://developer.mozilla.org/en-US/docs/Web/CSS/@keyframes
