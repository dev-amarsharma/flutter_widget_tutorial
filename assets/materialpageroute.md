## MaterialPageRoute

In Flutter, the MaterialPageRoute widget is a modal route that uses a material page transition. It is commonly used for navigation between screens.

```dart
MaterialPageRoute(
  builder: (context) => NextPage(),
)
```

The main parameters of the MaterialPageRoute widget are:

- **builder**: The widget builder for the route (required).
- **settings**: Route settings.
- **fullscreenDialog**: Whether the route is a fullscreen dialog.

### Quick Tips:
- Use for standard page transitions.
- Use fullscreenDialog for modal screens.


### Things to Avoid:
- Avoid using for Cupertino apps—use CupertinoPageRoute instead.
- Don’t forget to pop the route when done.

## Class Definition

```dart
class MaterialPageRoute<T> extends PageRoute<T> {
  MaterialPageRoute({
    required this.builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(settings: settings, fullscreenDialog: fullscreenDialog, maintainState: maintainState);

  final WidgetBuilder builder;

  // ...
}
```
