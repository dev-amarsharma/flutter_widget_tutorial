import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Achievement {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  const Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}

const List<Achievement> allAchievements = [
  Achievement(
    id: 'first_step',
    name: 'First Step',
    description: 'Read your first lesson',
    icon: Icons.school,
    color: Color(0xFF4CAF50),
  ),
  Achievement(
    id: 'bookworm',
    name: 'Bookworm',
    description: 'Read 10 lessons',
    icon: Icons.menu_book,
    color: Color(0xFF2196F3),
  ),
  Achievement(
    id: 'scholar',
    name: 'Scholar',
    description: 'Read 25 lessons',
    icon: Icons.auto_stories,
    color: Color(0xFF9C27B0),
  ),
  Achievement(
    id: 'quiz_debut',
    name: 'Quiz Debut',
    description: 'Complete your first quiz',
    icon: Icons.quiz,
    color: Color(0xFFFF9800),
  ),
  Achievement(
    id: 'quiz_ace',
    name: 'Quiz Ace',
    description: 'Score 100% on any quiz',
    icon: Icons.star,
    color: Color(0xFFFFC107),
  ),
  Achievement(
    id: 'on_a_roll',
    name: 'On a Roll',
    description: 'Maintain a 3-day streak',
    icon: Icons.local_fire_department,
    color: Color(0xFFFF5722),
  ),
  Achievement(
    id: 'dedicated',
    name: 'Dedicated',
    description: 'Maintain a 7-day streak',
    icon: Icons.emoji_events,
    color: Color(0xFFE91E63),
  ),
  Achievement(
    id: 'xp_hunter',
    name: 'XP Hunter',
    description: 'Earn 500 XP total',
    icon: Icons.bolt,
    color: Color(0xFF00BCD4),
  ),
  Achievement(
    id: 'challenger',
    name: 'Daily Challenger',
    description: 'Complete the daily challenge',
    icon: Icons.today,
    color: Color(0xFF607D8B),
  ),
];

class AchievementService {
  static const String _prefsKey = 'unlocked_achievement_ids';

  static final AchievementService _instance = AchievementService._internal();
  factory AchievementService() => _instance;
  AchievementService._internal();

  Set<String> _unlockedIds = {};

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_prefsKey);
    if (saved != null) {
      _unlockedIds = saved.toSet();
    }
  }

  Set<String> get unlockedIds => Set.unmodifiable(_unlockedIds);

  bool isUnlocked(String id) => _unlockedIds.contains(id);

  /// Checks conditions and unlocks newly earned achievements.
  /// Returns the list of achievements that were just unlocked.
  Future<List<Achievement>> checkAndUnlock({
    required int readCount,
    required int streakCount,
    required int totalXp,
    required int level,
    required Map<String, int> quizScores,
    bool dailyChallengeCompleted = false,
  }) async {
    final newlyUnlocked = <Achievement>[];

    for (final a in allAchievements) {
      if (_unlockedIds.contains(a.id)) continue;
      if (_conditionMet(
        a.id,
        readCount: readCount,
        streakCount: streakCount,
        totalXp: totalXp,
        level: level,
        quizScores: quizScores,
        dailyChallengeCompleted: dailyChallengeCompleted,
      )) {
        _unlockedIds.add(a.id);
        newlyUnlocked.add(a);
      }
    }

    if (newlyUnlocked.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_prefsKey, _unlockedIds.toList());
    }

    return newlyUnlocked;
  }

  bool _conditionMet(
    String id, {
    required int readCount,
    required int streakCount,
    required int totalXp,
    required int level,
    required Map<String, int> quizScores,
    required bool dailyChallengeCompleted,
  }) {
    switch (id) {
      case 'first_step':
        return readCount >= 1;
      case 'bookworm':
        return readCount >= 10;
      case 'scholar':
        return readCount >= 25;
      case 'quiz_debut':
        return quizScores.isNotEmpty;
      case 'quiz_ace':
        return quizScores.values.any((s) => s >= 100);
      case 'on_a_roll':
        return streakCount >= 3;
      case 'dedicated':
        return streakCount >= 7;
      case 'xp_hunter':
        return totalXp >= 500;
      case 'challenger':
        return dailyChallengeCompleted;
      default:
        return false;
    }
  }

  Future<void> clearAll() async {
    _unlockedIds.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
  }
}

final achievementService = AchievementService();
