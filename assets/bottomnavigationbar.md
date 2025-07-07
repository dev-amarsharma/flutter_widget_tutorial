## BottomNavigationBar

In Flutter, the BottomNavigationBar widget displays a bar at the bottom of the app for navigation between top-level views.

```dart
BottomNavigationBar(
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ],
)
```

The main parameters of the Flutter BottomNavigationBar widget are:

- **items**: The list of navigation items (required).
- **currentIndex**: The index of the selected item.
- **onTap**: Callback when an item is tapped.
- **type**: The layout type (fixed or shifting).
- **backgroundColor**: The background color of the bar.

### Quick Tips:
- Use for top-level navigation.
- Use icons and labels for clarity.


### Things to Avoid:
- Avoid using for more than 5 items.
- Don’t use for secondary navigation.

## Class Definition

```dart
class BottomNavigationBar extends StatefulWidget {
  const BottomNavigationBar({
    Key? key,
    required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.elevation,
    this.type,
    this.fixedColor,
    this.backgroundColor,
    this.iconSize = 24.0,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedIconTheme = const IconThemeData(),
    this.unselectedIconTheme = const IconThemeData(),
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels = true,
    this.showUnselectedLabels,
    this.mouseCursor,
    this.enableFeedback,
    this.landscapeLayout,
    this.useLegacyColorScheme = false,
  }) : super(key: key);

  // ...
}
```
