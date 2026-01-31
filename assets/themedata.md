# ThemeData

Defines the visual properties of a theme.

---

## Description

The `ThemeData` class in Flutter holds the configuration for a theme, including colors, text styles, and other visual properties. It's used with the `Theme` widget to create a consistent look and feel throughout your app. `ThemeData` provides a comprehensive set of properties that control the appearance of Material Design widgets.

- **Common use cases:**
  - Defining app-wide color schemes
  - Setting consistent text styles
  - Configuring Material Design component appearances
  - Creating light and dark themes
  - Customizing button styles, card styles, and more

---

## Example

```dart
ThemeData(
  primaryColor: Colors.blue,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
)
```

---

## Class Definition

```dart
class ThemeData {
  const ThemeData({
    this.brightness,
    this.primaryColor,
    this.scaffoldBackgroundColor,
    this.appBarTheme,
    this.textTheme,
    this.buttonTheme,
    this.cardTheme,
    this.inputDecorationTheme,
    // ... many more properties
  });

  final Brightness? brightness;
  final Color? primaryColor;
  final Color? scaffoldBackgroundColor;
  final AppBarTheme? appBarTheme;
  final TextTheme? textTheme;
  final ButtonThemeData? buttonTheme;
  final CardTheme? cardTheme;
  final InputDecorationTheme? inputDecorationTheme;
  // ... many more properties

  // ...
}
```

---

## Properties

| Name                    | Type                    | Description                                      |
|-------------------------|-------------------------|--------------------------------------------------|
| `brightness`            | Brightness?             | The overall brightness of the theme.             |
| `primaryColor`          | Color?                  | The primary color of the theme.                  |
| `scaffoldBackgroundColor` | Color?               | The background color for Scaffold.               |
| `appBarTheme`           | AppBarTheme?            | Theme for AppBar widgets.                        |
| `textTheme`             | TextTheme?              | Text styles for different text variants.          |
| `buttonTheme`           | ButtonThemeData?        | Theme for button widgets.                        |
| `cardTheme`             | CardTheme?              | Theme for Card widgets.                          |
| `inputDecorationTheme`  | InputDecorationTheme?   | Theme for input field decorations.               |
| `colorScheme`           | ColorScheme?            | A complete color scheme for the theme.           |
| `useMaterial3`          | bool                    | Whether to use Material 3 design.                |

---

## See Also

- [`Theme`](theme.md): The widget that applies ThemeData to its descendants.
- [`Theme.of(context)`](https://api.flutter.dev/flutter/material/Theme/of.html): Method to access the current theme data.
- [Official ThemeData docs](https://api.flutter.dev/flutter/material/ThemeData-class.html)
