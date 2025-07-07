## CupertinoNavigationBar

In Flutter, the CupertinoNavigationBar widget creates an iOS-style navigation bar. It is commonly used at the top of Cupertino screens.

```dart
CupertinoNavigationBar(
  middle: Text('Title'),
)
```

The main parameters of the CupertinoNavigationBar widget are:

- **middle**: The main widget in the center (usually a Text).
- **leading**: Widget before the middle.
- **trailing**: Widget after the middle.
- **backgroundColor**: The background color.

### Quick Tips:
- Use for top navigation in Cupertino apps.
- Combine with CupertinoPageScaffold.


### Things to Avoid:
- Avoid using for Material apps—use AppBar instead.
- Don’t overcrowd with too many widgets.

## Class Definition

```dart
class CupertinoNavigationBar extends StatelessWidget {
  const CupertinoNavigationBar({
    Key? key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.middle,
    this.trailing,
    this.backgroundColor,
    this.border,
    this.padding,
    this.transitionBetweenRoutes = true,
    this.heroTag = const _DefaultHeroTag(),
  }) : super(key: key);

  // ...
}
```
