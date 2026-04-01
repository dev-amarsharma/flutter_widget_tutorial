import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/app_config.dart';

class AppConfigService {
  static const String _configAsset = 'assets/app_config.json';

  AppConfig? _config;

  Future<AppConfig> loadConfig() async {
    if (_config != null) {
      return _config!;
    }

    final rawJson = await rootBundle.loadString(_configAsset);
    final decoded = jsonDecode(rawJson) as Map<String, dynamic>;
    _config = AppConfig.fromJson(decoded);
    return _config!;
  }

  AppConfig get config {
    final config = _config;
    if (config == null) {
      throw StateError(
        'AppConfigService not initialized. Call loadConfig() before use.',
      );
    }
    return config;
  }
}

final appConfigService = AppConfigService();
