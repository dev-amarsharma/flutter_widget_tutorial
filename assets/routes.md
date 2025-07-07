## Routes

In Flutter, routes are named strings that map to screens in your app. They are commonly used for navigation and deep linking.

```dart
MaterialApp(
  routes: {
    '/': (context) => HomePage(),
    '/details': (context) => DetailsPage(),
  },
)
```

The main parameters of routes are:

- **routes**: A map of route names to widget builders.
- **initialRoute**: The initial route to display.
- **onGenerateRoute**: Callback for dynamic route generation.

### Quick Tips:
- Use named routes for easier navigation.
- Use onGenerateRoute for dynamic routing.


### Things to Avoid:
- Avoid using too many nested routes.
- Don’t forget to define all used routes.

## Example Definition

```dart
MaterialApp(
  routes: <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    '/details': (BuildContext context) => DetailsPage(),
  },
  initialRoute: '/',
  onGenerateRoute: (RouteSettings settings) {
    // Custom route logic
  },
)
```
