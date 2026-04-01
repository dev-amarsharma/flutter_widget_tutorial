# main() and runApp()

Shows how a Flutter app starts and how the root widget is attached to the screen.

---

## Description

Every Flutter app begins in the `main()` function. Inside it, you usually call `runApp()` and pass the root widget of your application. That widget then builds the rest of the widget tree.

- **Common use cases:**
  - App startup
  - Initial service setup
  - Injecting the root widget
  - Configuring themes and app-level navigation

---

## Example

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Hello Flutter')),
      ),
    );
  }
}
```

---

## Key Points

- `main()` is the Dart entry point.
- `runApp()` takes a widget and makes it the root of the UI.
- App-wide setup often happens before `runApp()`.
- The root widget is commonly `MaterialApp` or `CupertinoApp`.

---

## Quick Tips

- Call `WidgetsFlutterBinding.ensureInitialized()` before async setup when needed.
- Keep startup code small and predictable.
- Put app-level configuration near the root widget.

---

## Things to Avoid

- Avoid heavy synchronous work in startup code.
- Avoid calling `runApp()` multiple times unless you know why.
- Do not mix unrelated setup logic into random widgets.

---

## See Also

- [`Flutter Project Structure`](assets/flutter_project_structure.md)
- [`MaterialApp`](assets/materialapp.md)
