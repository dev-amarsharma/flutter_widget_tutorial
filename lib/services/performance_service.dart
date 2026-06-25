import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// XP thresholds and level names for the XP system.
const List<int> xpThresholds = [0, 100, 300, 700, 1500, 3000];
const List<String> levelNames = [
  'Beginner',
  'Novice',
  'Intermediate',
  'Advanced',
  'Expert',
  'Master',
];

class PerformanceService {
  static const String _readAssetsKey = 'read_assets_list';
  static const String _quizScoresKey = 'quiz_scores_map';
  static const String _streakCountKey = 'streak_count';
  static const String _lastOpenDateKey = 'last_open_date';
  static const String _totalXpKey = 'total_xp';
  static const String _bookmarksKey = 'bookmarks_list';

  static const int _xpPerLesson = 10;

  // Singleton
  static final PerformanceService _instance = PerformanceService._internal();
  factory PerformanceService() => _instance;
  PerformanceService._internal();

  Set<String> _readAssets = {};
  Map<String, int> _quizScores = {}; // progressKey -> score (percentage 0-100)
  int _streakCount = 0;
  int _totalXp = 0;
  Set<String> _bookmarks = {};

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    // Load read assets
    final readList = prefs.getStringList(_readAssetsKey);
    if (readList != null) {
      _readAssets = readList.toSet();
    }

    // Load quiz scores
    final scoresJson = prefs.getString(_quizScoresKey);
    if (scoresJson != null) {
      try {
        final decoded = jsonDecode(scoresJson) as Map<String, dynamic>;
        _quizScores = {};
        decoded.forEach((key, value) {
          if (value is int) {
            _quizScores[key] = value;
          }
        });
      } catch (e) {
        print('Error decoding quiz scores: $e');
      }
    }

    // Load XP
    _totalXp = prefs.getInt(_totalXpKey) ?? 0;

    // Load bookmarks
    final bookmarkList = prefs.getStringList(_bookmarksKey);
    if (bookmarkList != null) {
      _bookmarks = bookmarkList.toSet();
    }

    // Update daily streak
    await _updateStreak(prefs);
  }

  Future<void> _updateStreak(SharedPreferences prefs) async {
    final today = _dateKey(DateTime.now());
    final lastOpen = prefs.getString(_lastOpenDateKey);
    final saved = prefs.getInt(_streakCountKey) ?? 0;

    if (lastOpen == null) {
      // First ever open
      _streakCount = 1;
    } else if (lastOpen == today) {
      // Already opened today — no change
      _streakCount = saved;
      return;
    } else {
      final yesterday = _dateKey(DateTime.now().subtract(const Duration(days: 1)));
      _streakCount = (lastOpen == yesterday) ? saved + 1 : 1;
    }

    await prefs.setInt(_streakCountKey, _streakCount);
    await prefs.setString(_lastOpenDateKey, today);
  }

  static String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  int get streakCount => _streakCount;
  int get totalXp => _totalXp;

  int get level {
    for (int i = xpThresholds.length - 1; i >= 0; i--) {
      if (_totalXp >= xpThresholds[i]) return i;
    }
    return 0;
  }

  String get levelName => levelNames[level];

  /// XP needed to reach the next level (0 when already at max level).
  int get xpToNextLevel {
    final next = level + 1;
    if (next >= xpThresholds.length) return 0;
    return xpThresholds[next] - _totalXp;
  }

  /// Progress within the current level band (0.0 – 1.0).
  double get levelProgress {
    final current = level;
    final next = current + 1;
    if (next >= xpThresholds.length) return 1.0;
    final band = xpThresholds[next] - xpThresholds[current];
    final earned = _totalXp - xpThresholds[current];
    return (earned / band).clamp(0.0, 1.0);
  }

  Set<String> get readAssets => _readAssets;
  Map<String, int> get quizScores => _quizScores;
  Set<String> get bookmarks => _bookmarks;

  bool isRead({
    String? topicId,
    required String assetPath,
  }) {
    return _readAssets.contains(topicId) || _readAssets.contains(assetPath);
  }

  bool isBookmarked({String? topicId, required String assetPath}) {
    final key = topicId ?? assetPath;
    return _bookmarks.contains(key);
  }

  Future<void> toggleBookmark(String assetPath, {String? topicId}) async {
    final key = topicId ?? assetPath;
    if (_bookmarks.contains(key)) {
      _bookmarks.remove(key);
    } else {
      _bookmarks.add(key);
    }
    await _saveBookmarks();
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_bookmarksKey, _bookmarks.toList());
  }

  int? getQuizScore({
    String? topicId,
    required String assetPath,
  }) {
    return _quizScores[topicId] ?? _quizScores[assetPath];
  }

  Future<void> markAsRead(
    String assetPath, {
    String? topicId,
  }) async {
    final progressKey = topicId ?? assetPath;
    if (!_readAssets.contains(progressKey)) {
      _readAssets.add(progressKey);
      _totalXp += _xpPerLesson;
      await Future.wait([_saveReadAssets(), _saveXp()]);
    }
  }

  Future<void> saveQuizScore(
    String assetPath,
    int score,
    int totalQuestions, {
    String? topicId,
  }) async {
    final percentage = (score / totalQuestions * 100).round();
    final progressKey = topicId ?? assetPath;

    final currentScore = _quizScores[progressKey] ?? _quizScores[assetPath] ?? -1;
    if (percentage > currentScore) {
      final xpGained = percentage - (currentScore < 0 ? 0 : currentScore);
      _quizScores[progressKey] = percentage;
      _totalXp += xpGained;
      await Future.wait([_saveQuizScores(), _saveXp()]);
    }
  }

  Future<void> _saveReadAssets() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_readAssetsKey, _readAssets.toList());
  }

  Future<void> _saveQuizScores() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_quizScoresKey, jsonEncode(_quizScores));
  }

  Future<void> addBonusXp(int xp) async {
    if (xp <= 0) return;
    _totalXp += xp;
    await _saveXp();
  }

  Future<void> _saveXp() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_totalXpKey, _totalXp);
  }

  Future<void> clearAll() async {
    _readAssets.clear();
    _quizScores.clear();
    _streakCount = 0;
    _totalXp = 0;
    _bookmarks.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_readAssetsKey);
    await prefs.remove(_quizScoresKey);
    await prefs.remove(_streakCountKey);
    await prefs.remove(_lastOpenDateKey);
    await prefs.remove(_totalXpKey);
    await prefs.remove(_bookmarksKey);
  }
}

final performanceService = PerformanceService();
