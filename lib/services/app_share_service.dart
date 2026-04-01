import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'app_config_service.dart';

class AppShareService {
  const AppShareService();

  Future<void> shareApp(
    BuildContext context, {
    String? extraText,
  }) async {
    final config = appConfigService.config;
    final defaultMessage =
        'Check out ${config.appName}. ${config.description}'
        '${config.playStoreUrl.isEmpty ? '' : '\n\nDownload it on Google Play:\n${config.playStoreUrl}'}';
    final message = extraText == null || extraText.trim().isEmpty
        ? defaultMessage
        : 'Check out ${config.appName}. ${config.description}\n\n$extraText'
            '${config.playStoreUrl.isEmpty ? '' : '\n\nDownload it on Google Play:\n${config.playStoreUrl}'}';
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      message,
      sharePositionOrigin:
          box == null ? null : box.localToGlobal(Offset.zero) & box.size,
    );
  }
}

const appShareService = AppShareService();
