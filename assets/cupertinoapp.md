## CupertinoApp

In Flutter, the CupertinoApp widget is the entry point for iOS-style apps. It provides Cupertino (iOS) design and navigation structure.

```dart
CupertinoApp(
  home: CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(
      middle: Text('Cupertino App'),
    ),
    child: Center(child: Text('Hello, Cupertino!')),
  ),
)
```

The main parameters of the CupertinoApp widget are:

- **home**: The widget for the default route.
- **routes**: Named routes for navigation.
- **theme**: The app's theme.
- **navigatorKey**: Key for navigation.

### Quick Tips:
- Use for iOS-styled apps.
- Combine with Cupertino widgets for a native look.


### Things to Avoid:
- Avoid mixing with MaterialApp in the same app.
- Don’t use for Android-styled apps.

## Class Definition

```dart
class CupertinoApp extends StatefulWidget {
  const CupertinoApp({
    Key? key,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
  }) : super(key: key);

  // ...
}
```
