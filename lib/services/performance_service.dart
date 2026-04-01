import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PerformanceService {
  static const String _readAssetsKey = 'read_assets_list';
  static const String _quizScoresKey = 'quiz_scores_map';

  // Singleton
  static final PerformanceService _instance = PerformanceService._internal();
  factory PerformanceService() => _instance;
  PerformanceService._internal();

  Set<String> _readAssets = {};
  Map<String, int> _quizScores = {}; // assetPath -> score (percentage 0-100)
  Map<String, int> _quizTotals = {}; // assetPath -> total questions

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
  }

  Set<String> get readAssets => _readAssets;
  Map<String, int> get quizScores => _quizScores;

  bool isRead({
    String? topicId,
    required String assetPath,
  }) {
    return _readAssets.contains(topicId) || _readAssets.contains(assetPath);
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
      await _saveReadAssets();
    }
  }

  Future<void> saveQuizScore(
    String assetPath,
    int score,
    int totalQuestions, {
    String? topicId,
  }) async {
    // Calculate percentage
    final percentage = (score / totalQuestions * 100).round();
    final progressKey = topicId ?? assetPath;
    
    // Only update if new score is higher or doesn't exist
    final currentScore = _quizScores[progressKey] ?? _quizScores[assetPath] ?? -1;
    if (percentage > currentScore) {
      _quizScores[progressKey] = percentage;
      await _saveQuizScores();
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

  Future<void> clearAll() async {
    _readAssets.clear();
    _quizScores.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_readAssetsKey);
    await prefs.remove(_quizScoresKey);
  }
}

final performanceService = PerformanceService();
