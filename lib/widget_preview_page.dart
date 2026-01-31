import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'widgets/banner_ad_widget.dart';
import 'services/interstitial_ad_service.dart';

class WidgetPreviewPage extends StatefulWidget {
  final String assetPath;
  final Set<String> readAssets;
  final void Function(String assetPath) onMarkAsRead;

  const WidgetPreviewPage({
    Key? key,
    required this.assetPath,
    required this.readAssets,
    required this.onMarkAsRead,
  }) : super(key: key);

  @override
  State<WidgetPreviewPage> createState() => _WidgetPreviewPageState();
}

class _WidgetPreviewPageState extends State<WidgetPreviewPage> {
  String? _markdownData;

  @override
  void initState() {
    super.initState();
    _loadMarkdown();
    // Track navigation for interstitial ad
    interstitialAdService.handleWidgetPageNavigation();
  }

  Future<void> _loadMarkdown() async {
    try {
      final data = await rootBundle.loadString(widget.assetPath);
      setState(() => _markdownData = data);
    } catch (e) {
      setState(() => _markdownData = 'Error loading ${widget.assetPath}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRead = widget.readAssets.contains(widget.assetPath);

    final styleSheet = MarkdownStyleSheet.fromTheme(theme).copyWith(
      h1: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
      h2: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.secondary,
      ),
      p: TextStyle(
        fontSize: 16,
        height: 1.6,
        color: theme.textTheme.bodyLarge?.color,
      ),
      code: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: theme.colorScheme.secondary,
      ),
      codeblockDecoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.08),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: theme.dividerColor),
      ),
      a: TextStyle(
        color: theme.colorScheme.secondary,
        decoration: TextDecoration.underline,
      ),
    );

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(widget.assetPath.split('/').last.replaceAll('.md', '')),
        backgroundColor:
            theme.appBarTheme.backgroundColor ?? theme.colorScheme.primary,
        titleTextStyle: theme.appBarTheme.titleTextStyle,
        actions: [
          IconButton(
            icon: Icon(isRead ? Icons.check_circle : Icons.check),
            tooltip: isRead ? 'Read' : 'Mark as read',
            onPressed:
                isRead ? null : () => widget.onMarkAsRead(widget.assetPath),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _markdownData == null
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Markdown(
                    data: _markdownData!,
                    styleSheet: styleSheet,
                    onTapLink: (text, href, title) async {
                      if (href != null &&
                          href.startsWith('assets/') &&
                          href.endsWith('.md')) {
                        // Track navigation for interstitial ad
                        await interstitialAdService.handleWidgetPageNavigation();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (_) => WidgetPreviewPage(
                                  assetPath: href,
                                  readAssets: widget.readAssets,
                                  onMarkAsRead: widget.onMarkAsRead,
                                ),
                          ),
                        );
                      } else if (href != null) {
                        // ignore: avoid_print
                        print('External link tapped: $href');
                      }
                    },
                  ),
                ),
          ),
          // Banner ad at the bottom
          const BannerAdWidget(),
        ],
      ),
    );
  }
}
