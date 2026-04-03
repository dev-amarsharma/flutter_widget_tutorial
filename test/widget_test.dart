import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tutorial/services/app_config_service.dart';
import 'package:flutter_tutorial/services/catalog_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('catalog only exposes loadable lesson and quiz assets', (
    WidgetTester tester,
  ) async {
    await appConfigService.loadConfig();

    final sections = await catalogService.loadCatalogSections();
    final items = sections.expand((section) => section.items).toList();

    expect(items, isNotEmpty);

    for (final item in items) {
      await rootBundle.loadString(item.assetPath);
      await rootBundle.loadString(item.quizAssetPath);
    }
  });
}
