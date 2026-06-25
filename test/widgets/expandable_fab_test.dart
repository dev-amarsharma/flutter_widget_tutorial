import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tutorial/widgets/expandable_fab.dart';

void main() {
  Widget buildHarness(List<ExpandableFabAction> actions) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: ExpandableFab(distance: 128, actions: actions),
      ),
    );
  }

  testWidgets('main button only toggles actions', (tester) async {
    var calls = 0;
    await tester.pumpWidget(
      buildHarness([
        ExpandableFabAction(
          icon: const Icon(Icons.bar_chart),
          tooltip: 'My Performance',
          onPressed: () => calls++,
        ),
      ]),
    );

    await tester.tap(find.byTooltip('Open actions'));
    await tester.pumpAndSettle();

    expect(calls, 0);
    expect(find.byTooltip('Close actions'), findsOneWidget);

    await tester.tap(find.byTooltip('My Performance'));
    await tester.pumpAndSettle();

    expect(calls, 1);
    expect(find.byTooltip('Open actions'), findsOneWidget);
  });

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
      for (var index = 0; index < count; index++) {
        expect(find.byKey(ValueKey('icon-$index')), findsOneWidget);
        expect(find.byTooltip('Action $index'), findsOneWidget);
      }
    });
  }
}
