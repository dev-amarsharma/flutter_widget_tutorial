# Flutter Project Structure

Explains the main folders and files in a Flutter project and what each one is used for.

---

## Description

A Flutter app contains source code, assets, platform-specific folders, and project configuration files. Understanding the basic structure helps you know where to place widgets, services, tests, and static content as the app grows.

- **Common areas in a Flutter project:**
  - `lib/` for Dart source code
  - `assets/` for images, markdown, and JSON
  - `test/` for automated tests
  - `pubspec.yaml` for dependencies and asset registration
  - `android/`, `ios/`, `web/`, and other platform folders

---

## Example

```text
my_app/
  lib/
  assets/
  test/
  pubspec.yaml
```

---

## Key Points

- Most app logic lives under `lib/`.
- Assets must usually be declared in `pubspec.yaml`.
- Platform folders contain native setup for each target platform.
- A clean folder structure makes features easier to maintain.

---

## Quick Tips

- Group files by feature when the app becomes larger.
- Keep assets named consistently.
- Place reusable services and models in predictable locations.

---

## Things to Avoid

- Avoid scattering related files across random folders.
- Avoid forgetting to register new assets.
- Do not put all app logic into one giant file.

---

## See Also

- [`main() and runApp()`](assets/main_runapp.md)
- [`MaterialApp`](assets/materialapp.md)
