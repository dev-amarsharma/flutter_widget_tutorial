import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class AppShareService {
  const AppShareService();

  static const String _playStoreUrl =
      'https://play.google.com/store/apps/details?id=digimonk.flutter.tutorial';
  static const String _defaultMessage =
      'Check out Flutter Learning Catalog. It includes Flutter learning topics, widget guides, and quizzes for practice.\n\nDownload it on Google Play:\nhttps://play.google.com/store/apps/details?id=digimonk.flutter.tutorial';

  Future<void> shareApp(
    BuildContext context, {
    String? extraText,
  }) async {
    final message = extraText == null || extraText.trim().isEmpty
        ? _defaultMessage
        : 'Check out Flutter Learning Catalog. It includes Flutter learning topics, widget guides, and quizzes for practice.\n\n$extraText\n\nDownload it on Google Play:\n$_playStoreUrl';
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      message,
      sharePositionOrigin:
          box == null ? null : box.localToGlobal(Offset.zero) & box.size,
    );
  }
}

const appShareService = AppShareService();
