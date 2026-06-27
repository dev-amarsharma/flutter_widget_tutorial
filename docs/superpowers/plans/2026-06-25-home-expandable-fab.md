# Home Expandable FAB Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the broken dual-purpose home FAB with a tested radial action menu and remove the header-title overlap without changing unrelated features.

**Architecture:** `ExpandableFab` will own menu animation, action layout, and close-before-dispatch behavior. Immutable `ExpandableFabAction` descriptors will let the home page build four or five state-dependent actions without inaccessible private widgets or placeholder children. The home page retains ownership of navigation and service calls; the catalog page only renders the catalog header and content.

**Tech Stack:** Flutter, Dart, Material widgets, `flutter_test`

---

## File Structure

- Create `test/widgets/expandable_fab_test.dart`: focused interaction, geometry, tooltip, and callback tests for the reusable FAB.
- Modify `lib/widgets/expandable_fab.dart`: action descriptor, radial layout, menu animation, and dispatch behavior.
- Modify `lib/main.dart`: construct the five home actions, hide Remove Ads after purchase, and host the notification settings sheet.
- Modify `lib/widget_catalog_page.dart`: keep the header action-free and remove obsolete private settings/purchase UI and imports.

### Task 1: Specify Expandable FAB Behavior

**Files:**
- Create: `test/widgets/expandable_fab_test.dart`
- Test: `test/widgets/expandable_fab_test.dart`

- [ ] **Step 1: Write failing interaction tests**

Create a MaterialApp/Scaffold harness with an `ExpandableFab` containing `ExpandableFabAction` values. Test that the closed main button exposes the `Open actions` tooltip, tapping it changes the tooltip to `Close actions`, and no action callback fires. Then tap the Performance action and assert that its callback fires once and the main tooltip returns to `Open actions`.

```dart
Widget buildHarness(List<ExpandableFabAction> actions) {
  return MaterialApp(
    home: Scaffold(
      floatingActionButton: ExpandableFab(
        distance: 128,
        actions: actions,
      ),
    ),
  );
}

testWidgets('main button only toggles actions', (tester) async {
  var calls = 0;
  await tester.pumpWidget(buildHarness([
    ExpandableFabAction(
      icon: const Icon(Icons.bar_chart),
      tooltip: 'My Performance',
      onPressed: () => calls++,
    ),
  ]));

  await tester.tap(find.byTooltip('Open actions'));
  await tester.pumpAndSettle();
  expect(calls, 0);
  expect(find.byTooltip('Close actions'), findsOneWidget);

  await tester.tap(find.byTooltip('My Performance'));
  await tester.pumpAndSettle();
  expect(calls, 1);
  expect(find.byTooltip('Open actions'), findsOneWidget);
});
```

- [ ] **Step 2: Write failing geometry and identity tests**

Build cases with one, four, and five actions. For five actions, open the menu, collect tooltip centers, and assert every adjacent distance is greater than the 40-pixel mini-FAB diameter. Assert each requested tooltip and icon is present.

```dart
for (final count in [1, 4, 5]) {
  testWidgets('lays out $count actions without overlap', (tester) async {
    final actions = List.generate(
      count,
      (index) => ExpandableFabAction(
        icon: Icon(Icons.circle, key: ValueKey('icon-$index')),
        tooltip: 'Action $index',
        onPressed: () {},
      ),
    );
    await tester.pumpWidget(buildHarness(actions));
    await tester.tap(find.byTooltip('Open actions'));
    await tester.pumpAndSettle();

    final centers = [
      for (var index = 0; index < count; index++)
        tester.getCenter(find.byTooltip('Action $index')),
    ];
    for (var index = 1; index < centers.length; index++) {
      expect((centers[index] - centers[index - 1]).distance, greaterThan(40));
    }
  });
}
```

- [ ] **Step 3: Run the focused tests and verify RED**

Run: `flutter test test/widgets/expandable_fab_test.dart`

Expected: compilation fails because `ExpandableFabAction` and the `actions` API do not exist.

- [ ] **Step 4: Commit the failing tests**

```bash
git add test/widgets/expandable_fab_test.dart
git commit -m "test: specify expandable fab behavior"
```

### Task 2: Implement the Reusable Expandable FAB

**Files:**
- Modify: `lib/widgets/expandable_fab.dart`
- Test: `test/widgets/expandable_fab_test.dart`

- [ ] **Step 1: Replace arbitrary children with action descriptors**

Define the public immutable API and validate its geometry inputs.

```dart
@immutable
class ExpandableFabAction {
  const ExpandableFabAction({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final Widget icon;
  final String tooltip;
  final VoidCallback onPressed;
}

class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen = false,
    required this.distance,
    required this.actions,
  }) : assert(distance > 0);

  final bool initialOpen;
  final double distance;
  final List<ExpandableFabAction> actions;
}
```

- [ ] **Step 2: Implement safe radial positioning**

Use a 90-degree arc. For one action use 90 degrees; otherwise calculate `90 / (count - 1)` and position actions from 90 through 0 degrees. Render each action with `FloatingActionButton.small`, a unique hero tag, and its tooltip. Ignore pointer input until expansion completes.

```dart
final step = count <= 1 ? 0.0 : 90.0 / (count - 1);
final direction = count <= 1 ? 90.0 : 90.0 - index * step;
```

- [ ] **Step 3: Implement toggle-only main FAB and close-before-dispatch**

Use `AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _controller)` inside the primary FAB. Its tooltip is `Open actions` or `Close actions`. Action taps call `_close()` before `action.onPressed()`; the main FAB never invokes a navigation callback.

```dart
void _runAction(ExpandableFabAction action) {
  _close();
  action.onPressed();
}
```

- [ ] **Step 4: Run focused tests and verify GREEN**

Run: `flutter test test/widgets/expandable_fab_test.dart`

Expected: all expandable FAB tests pass.

- [ ] **Step 5: Format and commit the component**

```bash
dart format lib/widgets/expandable_fab.dart test/widgets/expandable_fab_test.dart
git add lib/widgets/expandable_fab.dart test/widgets/expandable_fab_test.dart
git commit -m "feat: add tested expandable fab"
```

### Task 3: Wire Home Actions and Remove Broken References

**Files:**
- Modify: `lib/main.dart`
- Modify: `lib/widget_catalog_page.dart`

- [ ] **Step 1: Build the state-dependent home action list**

Wrap the `Scaffold` FAB slot in `ValueListenableBuilder<bool>` for `purchaseService.adsRemoved`. Construct actions in this order: Performance, conditional Remove Ads, Daily Reminder, Share App, Clear History. Set `distance: 128`.

```dart
floatingActionButton: ValueListenableBuilder<bool>(
  valueListenable: purchaseService.adsRemoved,
  builder: (context, adsRemoved, _) => ExpandableFab(
    distance: 128,
    actions: [
      ExpandableFabAction(
        icon: const Icon(Icons.bar_chart),
        tooltip: 'My Performance',
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const PerformanceScreen()),
        ),
      ),
      if (!adsRemoved)
        ExpandableFabAction(
          icon: const Icon(Icons.block),
          tooltip: 'Remove all ads',
          onPressed: () => _showRemoveAdsSheet(context),
        ),
      ExpandableFabAction(
        icon: Icon(
          notificationService.isDailyReminderEnabled
              ? Icons.notifications_active
              : Icons.notifications_none,
        ),
        tooltip: notificationService.isDailyReminderEnabled
            ? 'Daily reminder on'
            : 'Set daily reminder',
        onPressed: () async {
          await _showNotificationSheet(context);
          if (mounted) setState(() {});
        },
      ),
      ExpandableFabAction(
        icon: const Icon(Icons.share),
        tooltip: 'Share app',
        onPressed: () => appShareService.shareApp(context),
      ),
      ExpandableFabAction(
        icon: const Icon(Icons.delete_outline),
        tooltip: 'Clear read history',
        onPressed: () => _confirmAndClearHistory(context),
      ),
    ],
  ),
),
```

Add the complete Clear History handler. It invokes the three existing reset services and never calls nonexistent `widget.onClear`.

```dart
Future<void> _confirmAndClearHistory(BuildContext context) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => CustomDialog(
      title: 'Clear History?',
      message:
          'This will clear all saved "read" marks and your scroll position. This action cannot be undone.',
      icon: Icons.delete_forever_rounded,
      iconColor: Colors.red,
      primaryButtonText: 'Clear',
      onPrimaryPressed: () => Navigator.of(dialogContext).pop(true),
      secondaryButtonText: 'Cancel',
      onSecondaryPressed: () => Navigator.of(dialogContext).pop(false),
    ),
  );
  if (confirm != true) return;

  await performanceService.clearAll();
  await achievementService.clearAll();
  await dailyChallengeService.clearAll();
  if (!mounted) return;
  setState(() => _readAssets = performanceService.readAssets);
}
```

- [ ] **Step 2: Make notification settings available to the home page**

Move `_NotificationSettingsSheet` and its state class from `widget_catalog_page.dart` to `main.dart` below `_MyHomePageState`. Preserve reminder enablement, time picking, saving, and mounted checks. The home `_showNotificationSheet` then resolves locally without crossing a Dart library privacy boundary.

- [ ] **Step 3: Remove obsolete catalog code**

Delete the unused `_showNotificationSheet`, `_showRemoveAdsSheet`, `_NotificationSettingsSheet`, and `_NotificationSettingsSheetState` declarations from `widget_catalog_page.dart`. Remove imports that became unused: `app_share_service.dart`, `notification_service.dart`, `purchase_service.dart`, and `theme_service.dart`. Keep the `SliverAppBar` without an `actions` property.

- [ ] **Step 4: Run formatter and analyzer on affected files**

Run: `dart format lib/main.dart lib/widget_catalog_page.dart lib/widgets/expandable_fab.dart test/widgets/expandable_fab_test.dart`

Run: `flutter analyze lib/main.dart lib/widget_catalog_page.dart lib/widgets/expandable_fab.dart test/widgets/expandable_fab_test.dart`

Expected: no errors from the affected files. Existing deprecation or style infos may remain and must be reported separately.

- [ ] **Step 5: Commit the integration**

```bash
git add lib/main.dart lib/widget_catalog_page.dart
git commit -m "fix: complete home expandable fab actions"
```

### Task 4: Full Verification

**Files:**
- Verify: `lib/main.dart`
- Verify: `lib/widget_catalog_page.dart`
- Verify: `lib/widgets/expandable_fab.dart`
- Verify: `test/widgets/expandable_fab_test.dart`

- [ ] **Step 1: Run all tests**

Run: `flutter test`

Expected: all tests pass with zero failures.

- [ ] **Step 2: Run full static analysis**

Run: `flutter analyze`

Expected: zero analyzer errors. Record unrelated warnings and informational lints separately rather than silently claiming a clean analysis.

- [ ] **Step 3: Build the Android debug application**

Run: `flutter build apk --debug`

Expected: build exits successfully and produces `build/app/outputs/flutter-apk/app-debug.apk`.

- [ ] **Step 4: Review the final diff against the design**

Run: `git diff --check` and `git diff -- lib/main.dart lib/widget_catalog_page.dart lib/widgets/expandable_fab.dart test/widgets/expandable_fab_test.dart`

Expected: no whitespace errors; the diff contains only the planned FAB/header work in these files, while unrelated pre-existing worktree changes remain untouched.

- [ ] **Step 5: Commit any verification-only corrections**

If verification required a correction, stage only the four files above and commit it with a message describing that correction. If no correction was needed, do not create an empty commit.
