## Scaffold

In Flutter, the Scaffold widget provides the basic material design visual layout structure. It is commonly used as the top-level container for app screens.

```dart
Scaffold(
  appBar: AppBar(title: Text('Title')),
  body: Center(child: Text('Body')),
)
```

The main parameters of the Flutter Scaffold widget are:

- **appBar**: The top app bar.
- **body**: The main content of the screen.
- **drawer**: A navigation drawer.
- **bottomNavigationBar**: A bottom navigation bar.
- **floatingActionButton**: A floating action button.
- **backgroundColor**: The background color of the scaffold.

### Quick Tips:
- Use Scaffold as the root of each screen.
- Add drawers, snackbars, and bottom sheets easily.


### Things to Avoid:
- Avoid nesting multiple Scaffolds.
- Don’t use Scaffold for small widgets or components.

## Class Definition

```dart
class Scaffold extends StatefulWidget {
  const Scaffold({
    Key? key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  }) : super(key: key);

  // ...
}
```
