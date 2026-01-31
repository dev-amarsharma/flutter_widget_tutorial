# Theme

Applies a theme to descendant widgets.

---

## Description

The `Theme` widget in Flutter applies a `ThemeData` to its descendant widgets. It allows you to define a consistent visual style for your app, including colors, text styles, and other design elements. All widgets below the `Theme` widget in the widget tree will inherit the theme data.

- **Common use cases:**
  - Applying a consistent theme across your app
  - Creating themed sections within your app
  - Overriding the default Material theme
  - Implementing dark mode or light mode

---

## Example

```dart
Theme(
  data: ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    textTheme: TextTheme(
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
  ),
  child: Scaffold(
    appBar: AppBar(title: Text('Themed App')),
    body: Center(child: Text('Hello, Themed World!')),
  ),
)
```

---

## Class Definition

```dart
class Theme extends InheritedTheme {
  const Theme({
    Key? key,
    required this.data,
    required Widget child,
    this.isMaterialAppTheme = false,
  }) : super(key: key, child: child);

  final ThemeData data;
  final bool isMaterialAppTheme;

  // ...
}
```

---

## Properties

| Name                  | Type      | Description                                      |
|-----------------------|-----------|--------------------------------------------------|
| `data`                | ThemeData | The theme data to apply to descendants.          |
| `isMaterialAppTheme` | bool      | Whether this is the MaterialApp's theme.         |
| `child`               | Widget    | The widget below this widget in the tree.        |

---

## See Also

- [`ThemeData`](themedata.md): The data class that defines the theme properties.
- [`Theme.of(context)`](https://api.flutter.dev/flutter/material/Theme/of.html): Method to access the current theme.
- [Official Theme docs](https://api.flutter.dev/flutter/material/Theme-class.html)
