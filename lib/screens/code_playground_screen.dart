import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CodePlaygroundScreen extends StatefulWidget {
  final String? initialHtml;
  final String? initialCss;
  final String? initialJs;

  const CodePlaygroundScreen({
    super.key,
    this.initialHtml,
    this.initialCss,
    this.initialJs,
  });

  @override
  State<CodePlaygroundScreen> createState() =>
      _CodePlaygroundScreenState();
}

class _CodePlaygroundScreenState extends State<CodePlaygroundScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _htmlController;
  late TextEditingController _cssController;
  late TextEditingController _jsController;
  late WebViewController _webViewController;

  static const _defaultHtml = '<h1>Hello, World!</h1>\n'
      '<p>Edit the HTML, CSS, and JavaScript tabs, then tap Run!</p>\n'
      '<button onclick="greet()">Click me</button>';

  static const _defaultCss = 'body {\n'
      '  font-family: sans-serif;\n'
      '  padding: 20px;\n'
      '  background: #f5f5f5;\n'
      '}\n\n'
      'h1 { color: #ff6b35; }\n\n'
      'button {\n'
      '  background: #ff6b35;\n'
      '  color: white;\n'
      '  border: none;\n'
      '  padding: 8px 16px;\n'
      '  border-radius: 4px;\n'
      '  cursor: pointer;\n'
      '}';

  static const _defaultJs = 'function greet() {\n'
      "  alert('Hello from JavaScript!');\n"
      '}\n\n'
      "console.log('Playground ready!');";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _htmlController =
        TextEditingController(text: widget.initialHtml ?? _defaultHtml);
    _cssController =
        TextEditingController(text: widget.initialCss ?? _defaultCss);
    _jsController =
        TextEditingController(text: widget.initialJs ?? _defaultJs);

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white);

    WidgetsBinding.instance.addPostFrameCallback((_) => _runCode());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _htmlController.dispose();
    _cssController.dispose();
    _jsController.dispose();
    super.dispose();
  }

  String _buildHtmlPage() => '''<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
${_cssController.text}
</style>
</head>
<body>
${_htmlController.text}
<script>
${_jsController.text}
</script>
</body>
</html>''';

  void _runCode() => _webViewController.loadHtmlString(_buildHtmlPage());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Playground'),
        backgroundColor:
            theme.appBarTheme.backgroundColor ?? theme.colorScheme.primary,
        titleTextStyle: theme.appBarTheme.titleTextStyle,
        actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow_rounded),
            tooltip: 'Run',
            onPressed: _runCode,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'HTML'),
            Tab(text: 'CSS'),
            Tab(text: 'JavaScript'),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final editorHeight = constraints.maxHeight * 0.42;
          return Column(
            children: [
              SizedBox(
                height: editorHeight,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildEditor(_htmlController, isDark),
                    _buildEditor(_cssController, isDark),
                    _buildEditor(_jsController, isDark),
                  ],
                ),
              ),
              _buildPreviewBar(theme, isDark),
              Expanded(
                child: WebViewWidget(controller: _webViewController),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEditor(TextEditingController controller, bool isDark) {
    return Container(
      color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF6F8FA),
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        keyboardType: TextInputType.multiline,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          height: 1.5,
          color: isDark ? Colors.white : Colors.black87,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildPreviewBar(ThemeData theme, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
      child: Row(
        children: [
          Icon(
            Icons.preview_rounded,
            size: 15,
            color: isDark ? Colors.white60 : Colors.black54,
          ),
          const SizedBox(width: 6),
          Text(
            'Preview',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: _runCode,
            icon: const Icon(Icons.play_arrow_rounded, size: 16),
            label: const Text('Run', style: TextStyle(fontSize: 12)),
            style: TextButton.styleFrom(
              foregroundColor: Colors.deepOrange,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
