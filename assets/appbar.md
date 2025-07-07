## AppBar

In Flutter, the AppBar widget displays a material design app bar at the top of the screen. It is commonly used for titles, navigation, and actions.

```dart
AppBar(
  title: Text('Title'),
  actions: [Icon(Icons.settings)],
)
```

The main parameters of the Flutter AppBar widget are:

- **title**: The main widget displayed in the app bar.
- **actions**: Widgets displayed at the end of the app bar.
- **leading**: Widget displayed before the title.
- **backgroundColor**: The color of the app bar.
- **elevation**: The z-coordinate of the app bar.

### Quick Tips:
- Use actions for icons and buttons.
- Use leading for navigation icons.


### Things to Avoid:
- Avoid overcrowding the app bar with too many actions.
- Don’t use AppBar outside of a Scaffold.

## Class Definition

```dart
class AppBar extends StatefulWidget implements PreferredSizeWidget {
  const AppBar({
    Key? key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.scrolledUnderElevation,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.shadowColor,
    this.surfaceTintColor,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.toolbarHeight,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
    this.forceMaterialTransparency = false,
    this.clipBehavior,
  }) : super(key: key);

  // ...
}
```
