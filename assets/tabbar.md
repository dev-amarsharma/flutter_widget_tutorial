## TabBar & TabBarView

In Flutter, TabBar and TabBarView are used together to create tabbed interfaces. TabBar displays the tabs, and TabBarView displays the content.

```dart
DefaultTabController(
  length: 2,
  child: Column(
    children: [
      TabBar(tabs: [Tab(text: 'Tab 1'), Tab(text: 'Tab 2')]),
      Expanded(
        child: TabBarView(
          children: [Text('Content 1'), Text('Content 2')],
        ),
      ),
    ],
  ),
)
```

The main parameters of the Flutter TabBar and TabBarView widgets are:

- **tabs**: The list of tabs (TabBar).
- **controller**: Controls the selected tab.
- **children**: The content for each tab (TabBarView).
- **isScrollable**: Whether tabs can scroll horizontally.

### Quick Tips:
- Use DefaultTabController for simple tab setups.
- Use icons and text for tabs.


### Things to Avoid:
- Avoid using too many tabs.
- Don’t forget to match the number of tabs and views.

## Class Definition

```dart
class TabBar extends StatefulWidget {
  const TabBar({
    Key? key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
    this.indicatorColor,
    this.indicatorWeight = 2.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,
    this.indicatorSize,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.onTap,
    this.mouseCursor,
    this.overlayColor,
    this.automaticIndicatorColorAdjustment = true,
    this.splashFactory,
    this.enableFeedback,
    this.physics,
    this.padding,
    this.dividerColor,
  }) : super(key: key);

  // ...
}
```
