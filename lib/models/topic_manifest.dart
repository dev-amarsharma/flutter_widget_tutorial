class TopicManifest {
  final int version;
  final List<LearningTrack> tracks;
  final List<TopicMetadata> topics;

  const TopicManifest({
    required this.version,
    required this.tracks,
    required this.topics,
  });

  factory TopicManifest.fromJson(Map<String, dynamic> json) {
    return TopicManifest(
      version: json['version'] as int? ?? 1,
      tracks: (json['tracks'] as List<dynamic>? ?? const [])
          .map((track) => LearningTrack.fromJson(track as Map<String, dynamic>))
          .toList(),
      topics: (json['topics'] as List<dynamic>? ?? const [])
          .map((topic) => TopicMetadata.fromJson(topic as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, TopicMetadata> get topicsById => {
        for (final topic in topics) topic.id: topic,
      };
}

class LearningTrack {
  final String id;
  final String title;
  final String description;
  final String level;
  final List<String> topicIds;

  const LearningTrack({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.topicIds,
  });

  factory LearningTrack.fromJson(Map<String, dynamic> json) {
    return LearningTrack(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      level: json['level'] as String? ?? 'beginner',
      topicIds: List<String>.from(json['topicIds'] as List<dynamic>? ?? const []),
    );
  }
}

class TopicMetadata {
  final String id;
  final String title;
  final String category;
  final String level;
  final String type;
  final int estimatedMinutes;
  final String lessonAsset;
  final String quizAsset;
  final List<String> tags;
  final List<String> prerequisites;
  final List<String> relatedTopicIds;
  final bool isPublished;

  const TopicMetadata({
    required this.id,
    required this.title,
    required this.category,
    required this.level,
    required this.type,
    required this.estimatedMinutes,
    required this.lessonAsset,
    required this.quizAsset,
    required this.tags,
    required this.prerequisites,
    required this.relatedTopicIds,
    required this.isPublished,
  });

  factory TopicMetadata.fromJson(Map<String, dynamic> json) {
    return TopicMetadata(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String? ?? 'general',
      level: json['level'] as String? ?? 'beginner',
      type: json['type'] as String? ?? 'concept',
      estimatedMinutes: json['estimatedMinutes'] as int? ?? 0,
      lessonAsset: json['lessonAsset'] as String,
      quizAsset: json['quizAsset'] as String,
      tags: List<String>.from(json['tags'] as List<dynamic>? ?? const []),
      prerequisites:
          List<String>.from(json['prerequisites'] as List<dynamic>? ?? const []),
      relatedTopicIds:
          List<String>.from(json['relatedTopicIds'] as List<dynamic>? ?? const []),
      isPublished: json['isPublished'] as bool? ?? true,
    );
  }

  String get progressKey => id;
}
