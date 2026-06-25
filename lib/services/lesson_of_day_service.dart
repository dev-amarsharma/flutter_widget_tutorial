import 'package:shared_preferences/shared_preferences.dart';
import '../models/catalog_section.dart';

const _prefDate = 'lotd_date';
const _prefAsset = 'lotd_asset';

class LessonOfDayService {
  Future<CatalogItem?> getLessonOfDay(
    List<CatalogSection> sections, {
    required bool Function({
      required String? topicId,
      required String assetPath,
    }) isRead,
  }) async {
    final today = _todayString();
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString(_prefDate) == today) {
      final savedAsset = prefs.getString(_prefAsset);
      if (savedAsset != null) {
        for (final section in sections) {
          for (final item in section.items) {
            if (item.assetPath == savedAsset) return item;
          }
        }
      }
    }

    final unread = <CatalogItem>[];
    for (final section in sections) {
      for (final item in section.items) {
        if (item.isLegacy) continue;
        if (!isRead(topicId: item.topicId, assetPath: item.assetPath)) {
          unread.add(item);
        }
      }
    }

    if (unread.isEmpty) return null;

    final seed = _dayOfYear();
    final picked = unread[seed % unread.length];

    await prefs.setString(_prefDate, today);
    await prefs.setString(_prefAsset, picked.assetPath);

    return picked;
  }

  String _todayString() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  int _dayOfYear() {
    final now = DateTime.now();
    return now.difference(DateTime(now.year)).inDays + 1;
  }
}

final lessonOfDayService = LessonOfDayService();
