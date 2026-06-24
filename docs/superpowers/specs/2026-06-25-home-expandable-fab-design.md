# Home Expandable FAB Design

## Goal

Remove the home-page toolbar actions that overlap the header title and expose those actions through a conventional expandable floating action button.

## Scope

The home page will have one expandable FAB. Its primary button only opens and closes the action menu. The menu contains these actions:

1. My Performance
2. Remove Ads, hidden when ads have already been removed
3. Daily Reminder
4. Share App
5. Clear History

No other page toolbar or unrelated feature is changed.

## Interaction Design

The actions expand in a radial arc toward the available space above and to the left of the primary FAB. The radius must keep the mini FABs from overlapping at both four-action and five-action counts. The primary icon transitions between a menu icon and a close icon.

Tapping the primary FAB never navigates. Tapping an action closes the menu and then runs that action. Every action has a distinct Material icon and tooltip:

- Performance: `bar_chart`
- Remove Ads: `block`
- Daily Reminder: `notifications_none` or `notifications_active`
- Share App: `share`
- Clear History: `delete_outline`

The home `SliverAppBar` has no action icons, leaving the catalog title unobstructed in expanded and collapsed states.

## Component Design

`ExpandableFab` owns open/closed state, animation, radial positioning, accessibility tooltips, and action dispatch. It accepts action descriptors rather than arbitrary child widgets so it can close itself consistently before invoking an action.

`ExpandableFabAction` is an immutable descriptor containing an icon, tooltip, and callback.

The home page builds the action list from current application state. The Remove Ads action is omitted after purchase. The notification icon and tooltip reflect the reminder state. Existing purchase, notification, sharing, performance navigation, and history-clearing services remain responsible for their current behavior.

Notification settings and Remove Ads sheets must be callable from the home page. Private, unused copies left in `widget_catalog_page.dart` will be removed or relocated so ownership is unambiguous and the code compiles.

## Error Handling

Existing user-facing behavior remains in place: unavailable purchases show a snackbar, notification settings remain in their sheet, and clearing history still requires confirmation. Async callbacks check that their widget context is still mounted before using it after an await.

## Testing

Widget tests will verify that:

- The primary FAB initially hides actions.
- Tapping the primary FAB reveals all supplied actions without invoking navigation or an action callback.
- Tapping an action invokes only that callback and closes the menu.
- The component supports one, four, and five actions without invalid angle calculations or overlapping positions.
- Tooltips and icons identify each action.

Static analysis and the existing Flutter test suite will run after implementation. Any unrelated pre-existing warnings will be reported separately from task-specific errors.
