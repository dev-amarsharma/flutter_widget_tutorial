import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  FirebaseAnalytics? _analytics;

  void init(FirebaseAnalytics analytics) {
    _analytics = analytics;
  }

  Future<void> logLessonOpened(String topicId, String topicName) async {
    await _analytics?.logEvent(
      name: 'lesson_opened',
      parameters: {'topic_id': topicId, 'topic_name': topicName},
    );
  }

  Future<void> logQuizCompleted({
    required String topicId,
    required int score,
    required int totalQuestions,
  }) async {
    await _analytics?.logEvent(
      name: 'quiz_completed',
      parameters: {
        'topic_id': topicId,
        'score': score,
        'total_questions': totalQuestions,
        'percentage': (score / totalQuestions * 100).round(),
      },
    );
  }

  Future<void> logLevelUp(int newLevel, String levelName) async {
    await _analytics?.logEvent(
      name: 'level_up',
      parameters: {'level': newLevel, 'level_name': levelName},
    );
  }

  Future<void> logScreenView(String screenName) async {
    await _analytics?.logScreenView(screenName: screenName);
  }

  Future<void> logAdShown(String adType) async {
    await _analytics?.logEvent(
      name: 'ad_shown',
      parameters: {'ad_type': adType},
    );
  }
}

final analyticsService = AnalyticsService();
