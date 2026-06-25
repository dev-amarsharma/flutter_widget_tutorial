import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/catalog_section.dart';
import '../models/quiz_question.dart';

const _prefChallengeDate = 'daily_challenge_date';
const _prefChallengeCompleted = 'daily_challenge_completed';

const int dailyChallengeQuestionCount = 5;
const int dailyChallengeTimerSeconds = 20;
const int dailyChallengeBonusXp = 50;

class DailyChallengeService {
  static final DailyChallengeService _instance =
      DailyChallengeService._internal();
  factory DailyChallengeService() => _instance;
  DailyChallengeService._internal();

  bool _completedToday = false;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDate = prefs.getString(_prefChallengeDate);
    if (savedDate == _todayString()) {
      _completedToday = prefs.getBool(_prefChallengeCompleted) ?? false;
    } else {
      _completedToday = false;
    }
  }

  bool get isCompletedToday => _completedToday;

  /// Loads 5 questions from non-legacy catalog items, seeded by day-of-year
  /// so the same 5 questions are offered all day.
  Future<List<QuizQuestion>> loadQuestions(
      List<CatalogSection> sections) async {
    final allQuestions = <QuizQuestion>[];

    for (final section in sections) {
      for (final item in section.items) {
        if (item.isLegacy) continue;
        try {
          final data = await rootBundle.loadString(item.quizAssetPath);
          final list = jsonDecode(data) as List<dynamic>;
          allQuestions.addAll(QuizQuestion.fromJsonList(list));
        } catch (_) {
          // quiz file unavailable, skip
        }
      }
    }

    if (allQuestions.isEmpty) return const [];

    final rng = Random(_dayOfYear());
    final shuffled = List<QuizQuestion>.from(allQuestions)..shuffle(rng);
    return shuffled
        .take(dailyChallengeQuestionCount.clamp(0, shuffled.length))
        .toList();
  }

  /// Marks today's challenge as completed and returns the bonus XP awarded.
  Future<int> markCompleted() async {
    _completedToday = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefChallengeDate, _todayString());
    await prefs.setBool(_prefChallengeCompleted, true);
    return dailyChallengeBonusXp;
  }

  Future<void> clearAll() async {
    _completedToday = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefChallengeDate);
    await prefs.remove(_prefChallengeCompleted);
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

final dailyChallengeService = DailyChallengeService();
