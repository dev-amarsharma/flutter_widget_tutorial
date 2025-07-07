## CupertinoButton

In Flutter, the CupertinoButton widget creates an iOS-style button. It is commonly used for actions in Cupertino apps.

```dart
CupertinoButton(
  child: Text('Press Me'),
  onPressed: () {},
)
```

The main parameters of the CupertinoButton widget are:

- **child**: The widget below this button (required).
- **onPressed**: Callback when the button is pressed (required).
- **color**: The background color.
- **padding**: The padding inside the button.

### Quick Tips:
- Use for actions in Cupertino apps.
- Combine with CupertinoApp for a native look.


### Things to Avoid:
- Avoid using for Material apps—use ElevatedButton instead.
- Don’t forget to provide an onPressed callback.

## Class Definition

```dart
class CupertinoButton extends StatelessWidget {
  const CupertinoButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.padding,
    this.color,
    this.disabledColor,
    this.minSize = 44.0,
    this.pressedOpacity = 0.4,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.alignment = Alignment.center,
    this.autofocus = false,
    this.focusNode,
  }) : super(key: key);

  // ...
}
```
