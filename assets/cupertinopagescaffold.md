## CupertinoPageScaffold

In Flutter, the CupertinoPageScaffold widget provides the basic structure for a Cupertino page. It is commonly used as the root of each screen in a Cupertino app.

```dart
CupertinoPageScaffold(
  navigationBar: CupertinoNavigationBar(
    middle: Text('Title'),
  ),
  child: Center(child: Text('Content')),
)
```

The main parameters of the CupertinoPageScaffold widget are:

- **navigationBar**: The navigation bar at the top.
- **child**: The main content of the page (required).
- **backgroundColor**: The background color.

### Quick Tips:
- Use as the root of each Cupertino screen.
- Combine with CupertinoNavigationBar.


### Things to Avoid:
- Avoid using for Material apps—use Scaffold instead.
- Don’t nest multiple CupertinoPageScaffolds.

## Class Definition

```dart
class CupertinoPageScaffold extends StatelessWidget {
  const CupertinoPageScaffold({
    Key? key,
    this.navigationBar,
    required this.child,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.restorationId,
  }) : super(key: key);

  // ...
}
```
