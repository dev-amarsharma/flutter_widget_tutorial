import 'package:flutter/material.dart';

class AppConfig {
  final String appName;
  final String materialAppTitle;
  final String catalogTitle;
  final String primaryTopic;
  final String description;
  final String playStoreUrl;
  final AppFeatures features;
  final AppThemeConfig theme;

  const AppConfig({
    required this.appName,
    required this.materialAppTitle,
    required this.catalogTitle,
    required this.primaryTopic,
    required this.description,
    required this.playStoreUrl,
    required this.features,
    required this.theme,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      appName: json['appName'] as String? ?? 'Learning Catalog',
      materialAppTitle:
          json['materialAppTitle'] as String? ??
          json['appName'] as String? ??
          'Learning Catalog',
      catalogTitle:
          json['catalogTitle'] as String? ??
          json['appName'] as String? ??
          'Learning Catalog',
      primaryTopic: json['primaryTopic'] as String? ?? 'Programming',
      description:
          json['description'] as String? ??
          'Learn with lessons, quizzes, and progress tracking.',
      playStoreUrl: json['playStoreUrl'] as String? ?? '',
      features: AppFeatures.fromJson(
        json['features'] as Map<String, dynamic>? ?? const {},
      ),
      theme: AppThemeConfig.fromJson(
        json['theme'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }
}

class AppFeatures {
  final bool enableLegacyCatalogFallback;

  const AppFeatures({
    required this.enableLegacyCatalogFallback,
  });

  factory AppFeatures.fromJson(Map<String, dynamic> json) {
    return AppFeatures(
      enableLegacyCatalogFallback:
          json['enableLegacyCatalogFallback'] as bool? ?? false,
    );
  }
}

class AppThemeConfig {
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color icon;
  final Color fabBackground;
  final Color fabForeground;

  const AppThemeConfig({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.icon,
    required this.fabBackground,
    required this.fabForeground,
  });

  factory AppThemeConfig.fromJson(Map<String, dynamic> json) {
    return AppThemeConfig(
      primary: _parseColor(json['primary'] as String?, const Color(0xFFFF8C00)),
      onPrimary: _parseColor(json['onPrimary'] as String?, Colors.black),
      secondary: _parseColor(
        json['secondary'] as String?,
        const Color(0xFF795548),
      ),
      onSecondary: _parseColor(json['onSecondary'] as String?, Colors.white),
      background: _parseColor(json['background'] as String?, Colors.white),
      onBackground: _parseColor(json['onBackground'] as String?, Colors.black),
      surface: _parseColor(json['surface'] as String?, const Color(0xFFBDBDBD)),
      onSurface: _parseColor(json['onSurface'] as String?, Colors.black),
      icon: _parseColor(json['icon'] as String?, const Color(0xFF795548)),
      fabBackground: _parseColor(
        json['fabBackground'] as String?,
        const Color(0xFF795548),
      ),
      fabForeground: _parseColor(
        json['fabForeground'] as String?,
        Colors.white,
      ),
    );
  }

  static Color _parseColor(String? hex, Color fallback) {
    if (hex == null || hex.isEmpty) {
      return fallback;
    }

    final normalized = hex.replaceFirst('#', '');
    final value = normalized.length == 6 ? 'FF$normalized' : normalized;
    return Color(int.parse(value, radix: 16));
  }
}
