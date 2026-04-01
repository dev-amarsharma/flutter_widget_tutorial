# SharedPreferences

Stores small pieces of simple local data on the device.

---

## Description

`shared_preferences` is useful for lightweight persistence such as:

- onboarding completion flags
- theme mode selection
- saved settings
- last selected tab
- small user preferences

It is not intended for large structured databases or complex offline data models.

---

## Example

```dart
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveThemeMode(bool isDark) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('dark_mode', isDark);
}

Future<bool> loadThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('dark_mode') ?? false;
}
```

---

## Key Points

- Access preferences through `SharedPreferences.getInstance()`.
- Use methods like `setBool`, `setInt`, `setString`, and matching getters.
- Provide fallback values when keys are missing.
- Keep stored values small and simple.

---

## Quick Tips

- Use clear key names like `dark_mode` or `has_seen_onboarding`.
- Wrap preference access in a service when the app grows.
- Load persisted settings early if they affect startup UI.

---

## Things to Avoid

- Do not use shared preferences for large structured datasets.
- Avoid scattering preference keys across many unrelated widgets.
- Do not assume a key always exists.

---

## See Also

- [`Form and Validation`](assets/form_validation.md)
- [`HTTP Requests`](assets/http_requests.md)
- [`setState Basics`](assets/setstate_basics.md)
