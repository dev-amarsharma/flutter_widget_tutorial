
# Cupertino Tab Bar

The `CupertinoTabBar` widget in Flutter creates an iOS-style bottom tab bar. It is commonly used for navigation in Cupertino apps.

## Class Definition

```dart
CupertinoTabBar({
  Key? key,
  required List<BottomNavigationBarItem> items,
  Color? backgroundColor,
  int currentIndex = 0,
  ValueChanged<int>? onTap,
  Color? activeColor,
  Color? inactiveColor,
  double iconSize = 30.0,
  Border? border,
})
```

```dart
CupertinoTabBar(
  items: [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'Settings'),
  ],
)
```

The main parameters of the CupertinoTabBar widget are:

- **items**: The list of tab items (required).
- **currentIndex**: The index of the selected tab.
- **onTap**: Callback when a tab is tapped.
- **backgroundColor**: The background color.

### Quick Tips:
- Use for bottom navigation in Cupertino apps.
- Use icons and labels for clarity.

### Things to Avoid:
- Avoid using for Material apps—use BottomNavigationBar instead.
- Don’t use for more than 5 tabs.
