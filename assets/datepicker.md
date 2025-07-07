## DatePicker

In Flutter, the DatePicker is not a widget but a function that shows a date selection dialog. Use `showDatePicker` to let the user pick a date.

```dart
showDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2000),
  lastDate: DateTime(2100),
)
```

The main parameters of the Flutter showDatePicker function are:

- **context**: The build context (required).
- **initialDate**: The date initially selected (required).
- **firstDate**: The earliest allowable date (required).
- **lastDate**: The latest allowable date (required).
- **onDateChanged**: Called when the user selects a date.
- **builder**: Customizes the dialog appearance.

### Quick Tips:
- Use in response to a button or field tap.
- Validate the selected date before saving.


### Things to Avoid:
- Avoid using showDatePicker for time selection—use showTimePicker instead.
- Don’t forget to handle null if the user cancels.

## Function Definition

```dart
Future<DateTime?> showDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
  SelectableDayPredicate? selectableDayPredicate,
  String? helpText,
  String? cancelText,
  String? confirmText,
  Locale? locale,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  TextDirection? textDirection,
  TransitionBuilder? builder,
  DatePickerMode initialDatePickerMode = DatePickerMode.day,
  String? errorFormatText,
  String? errorInvalidText,
  String? fieldHintText,
  String? fieldLabelText,
  TextInputType? keyboardType,
  DatePickerDateOrder? dateOrder,
  DatePickerDateTimeOrder? dateTimeOrder,
  Offset? anchorPoint,
})
```
