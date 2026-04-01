import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/topic_manifest.dart';

class TopicsManifestRepository {
  static const String _manifestAsset = 'assets/topics_manifest.json';

  TopicManifest? _cachedManifest;

  Future<TopicManifest> loadManifest() async {
    if (_cachedManifest != null) {
      return _cachedManifest!;
    }

    final rawJson = await rootBundle.loadString(_manifestAsset);
    final decoded = jsonDecode(rawJson) as Map<String, dynamic>;
    _cachedManifest = TopicManifest.fromJson(decoded);
    return _cachedManifest!;
  }

  Future<List<TopicMetadata>> loadPublishedTopics() async {
    final manifest = await loadManifest();
    return manifest.topics.where((topic) => topic.isPublished).toList();
  }

  Future<List<LearningTrack>> loadTracks({bool publishedOnly = true}) async {
    final manifest = await loadManifest();
    if (!publishedOnly) {
      return manifest.tracks;
    }

    final publishedTopicIds = manifest.topics
        .where((topic) => topic.isPublished)
        .map((topic) => topic.id)
        .toSet();

    return manifest.tracks
        .map(
          (track) => LearningTrack(
            id: track.id,
            title: track.title,
            description: track.description,
            level: track.level,
            topicIds: track.topicIds
                .where((topicId) => publishedTopicIds.contains(topicId))
                .toList(),
          ),
        )
        .where((track) => track.topicIds.isNotEmpty)
        .toList();
  }

  Future<List<TopicMetadata>> loadTopicsForTrack(
    String trackId, {
    bool publishedOnly = true,
  }) async {
    final manifest = await loadManifest();
    final track = manifest.tracks.firstWhere(
      (item) => item.id == trackId,
      orElse: () => throw StateError('Unknown track id: $trackId'),
    );
    final topicsById = manifest.topicsById;

    return track.topicIds
        .map((topicId) => topicsById[topicId])
        .whereType<TopicMetadata>()
        .where((topic) => !publishedOnly || topic.isPublished)
        .toList();
  }

  Future<TopicMetadata?> findTopicById(String topicId) async {
    final manifest = await loadManifest();
    return manifest.topicsById[topicId];
  }

  Future<List<TopicMetadata>> findTopicsByIds(
    List<String> topicIds, {
    bool publishedOnly = true,
  }) async {
    final manifest = await loadManifest();
    return topicIds
        .map((topicId) => manifest.topicsById[topicId])
        .whereType<TopicMetadata>()
        .where((topic) => !publishedOnly || topic.isPublished)
        .toList();
  }

  Future<TopicMetadata?> findTopicByLessonAsset(String lessonAsset) async {
    final manifest = await loadManifest();
    for (final topic in manifest.topics) {
      if (topic.lessonAsset == lessonAsset) {
        return topic;
      }
    }
    return null;
  }
}

final topicsManifestRepository = TopicsManifestRepository();
