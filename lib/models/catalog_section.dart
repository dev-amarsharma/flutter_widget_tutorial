class CatalogItem {
  final String name;
  final String assetPath;
  final String quizAssetPath;
  final String? topicId;
  final String category;
  final String level;
  final String type;
  final int? estimatedMinutes;
  final List<String> prerequisites;
  final String? description;
  final bool isLegacy;

  const CatalogItem({
    required this.name,
    required this.assetPath,
    required this.quizAssetPath,
    this.topicId,
    required this.category,
    required this.level,
    required this.type,
    this.estimatedMinutes,
    this.prerequisites = const [],
    this.description,
    this.isLegacy = false,
  });
}

class CatalogSection {
  final String title;
  final List<CatalogItem> items;
  final String? description;
  final String? level;

  const CatalogSection({
    required this.title,
    required this.items,
    this.description,
    this.level,
  });
}
