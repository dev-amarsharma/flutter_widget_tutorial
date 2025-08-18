import 'package:flutter/material.dart';
import 'widget_catalog_page.dart';
import 'widget_preview_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Custom color palette
    const goldust = Color(0xFFFF8C00); // Dark Orange
    const brown = Color(0xFF795548);
    const gray = Color(0xFFBDBDBD);
    const black = Colors.black;
    const white = Colors.white;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: goldust,
          onPrimary: black,
          secondary: brown,
          onSecondary: white,
          error: Colors.red,
          onError: white,
          background: white,
          onBackground: black,
          surface: gray,
          onSurface: black,
        ),
        scaffoldBackgroundColor: white,
        appBarTheme: const AppBarTheme(
          backgroundColor: goldust,
          foregroundColor: black,
          iconTheme: IconThemeData(color: black),
          titleTextStyle: TextStyle(
            color: black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: black),
          bodyMedium: TextStyle(color: black),
          bodySmall: TextStyle(color: brown),
        ),
        dividerColor: gray,
        cardColor: goldust,
        iconTheme: const IconThemeData(color: brown),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: brown,
          foregroundColor: white,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Widgets Categorized List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Track read status for each asset
  final Set<String> _readAssets = {};

  static const _prefsKey = 'read_assets_list';

  void _markAsRead() {
    if (_currentAssetPath != null) {
      setState(() {
        _readAssets.add(_currentAssetPath!);
      });
      _saveReadAssets();
    }
  }

  String? _markdownData;
  String? _currentAssetPath = 'assets/flutter_widgets_categorized_list.md';
  final List<String> _assetHistory = [
    'assets/flutter_widgets_categorized_list.md',
  ];

  bool get _showCatalogPage =>
      _currentAssetPath == 'assets/flutter_widgets_categorized_list.md';

  @override
  void initState() {
    super.initState();
    _loadReadAssets().then((_) => _loadMarkdownFile(_currentAssetPath!));
  }

  Future<void> _loadReadAssets() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? list = prefs.getStringList(_prefsKey);
      if (list != null) {
        setState(() {
          _readAssets.addAll(list);
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error loading read assets: $e');
    }
  }

  Future<void> _saveReadAssets() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_prefsKey, _readAssets.toList());
    } catch (e) {
      // ignore: avoid_print
      print('Error saving read assets: $e');
    }
  }

  Future<void> _loadMarkdownFile(String assetPath) async {
    try {
      final String data = await rootBundle.loadString(assetPath);
      setState(() {
        _markdownData = data;
        if (_currentAssetPath != assetPath) {
          _assetHistory.add(assetPath);
        }
        _currentAssetPath = assetPath;
      });
    } catch (e) {
      setState(() {
        _markdownData = 'Error loading file: $assetPath';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_assetHistory.length > 1) {
          _assetHistory.removeLast();
          final prevAsset = _assetHistory.last;
          await _loadMarkdownFile(prevAsset);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body:
            _showCatalogPage
                ? WidgetCatalogPage(
                  readAssets: _readAssets,
                  onOpenWidget: (assetPath) async {
                    // navigate to preview page
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (_) => WidgetPreviewPage(
                              assetPath: assetPath,
                              readAssets: _readAssets,
                              onMarkAsRead: (path) {
                                setState(() {
                                  _readAssets.add(path);
                                });
                                _saveReadAssets();
                              },
                            ),
                      ),
                    );
                  },
                  onClear: () async {
                    setState(() {
                      _readAssets.clear();
                    });
                    try {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('read_assets_list');
                      await prefs.remove('catalog_scroll_offset');
                    } catch (e) {
                      // ignore: avoid_print
                      print('Error clearing preferences: $e');
                    }
                  },
                )
                : Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: <Widget>[
                      // Back button row
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 0,
                          bottom: 8,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Color(0xFF795548),
                              ),
                              tooltip: 'Back',
                              onPressed: () async {
                                if (_assetHistory.length > 1) {
                                  _assetHistory.removeLast();
                                  final prevAsset = _assetHistory.last;
                                  await _loadMarkdownFile(prevAsset);
                                } else {
                                  Navigator.of(context).maybePop();
                                }
                              },
                            ),
                            const Spacer(),
                            if (_currentAssetPath != null &&
                                _currentAssetPath !=
                                    'assets/flutter_widgets_categorized_list.md')
                              ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _readAssets.contains(_currentAssetPath!)
                                          ? Color(0xFF388E3C) // green
                                          : Color(0xFF795548), // brown
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 2,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                ),
                                onPressed:
                                    _readAssets.contains(_currentAssetPath!)
                                        ? null
                                        : _markAsRead,
                                label: Text(
                                  _readAssets.contains(_currentAssetPath!)
                                      ? 'Read'
                                      : 'Mark as Read',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child:
                            _markdownData != null
                                ? Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Markdown(
                                    data: _markdownData!,
                                    styleSheet: MarkdownStyleSheet(
                                      h1: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFF8C00), // dark orange
                                      ),
                                      h2: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF795548), // brown
                                      ),
                                      h3: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFBDBDBD), // gray
                                      ),
                                      h4: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      p: const TextStyle(
                                        fontSize: 16,
                                        height: 1.6,
                                        color: Colors.black,
                                      ),
                                      code: const TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'monospace',
                                        fontSize: 12,
                                        color: Color(0xFF795548), // brown
                                      ),
                                      codeblockDecoration: BoxDecoration(
                                        color: Color(
                                          0xFFFFF8E1,
                                        ), // light gold background
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        border: Border.all(
                                          color: Color(0xFFBDBDBD), // gray
                                          width: 1,
                                        ),
                                      ),
                                      blockquote: const TextStyle(
                                        color: Color(0xFF795548), // brown
                                        fontStyle: FontStyle.italic,
                                      ),
                                      listBullet: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFFFF8C00), // dark orange
                                      ),
                                      tableHead: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                      tableCellsDecoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      tableCellsPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 4.0,
                                            vertical: 12,
                                          ),
                                      tableHeadAlign: TextAlign.center,
                                      tableBorder: TableBorder.all(
                                        color: Color(0xFF795548), // brown
                                        width: 1,
                                      ),
                                      tableColumnWidth: const FlexColumnWidth(),
                                      blockSpacing: 16,
                                      horizontalRuleDecoration:
                                          const BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                width: 2,
                                                color: Color(
                                                  0xFFBDBDBD,
                                                ), // gray
                                              ),
                                            ),
                                          ),
                                      a: const TextStyle(
                                        color: Color(0xFF795548), // brown
                                        decoration: TextDecoration.underline,
                                        fontSize: 16,
                                      ),
                                    ),
                                    onTapLink: (text, href, title) async {
                                      if (href != null &&
                                          href.startsWith('assets/') &&
                                          href.endsWith('.md')) {
                                        await _loadMarkdownFile(href);
                                      } else if (href != null) {
                                        // For web links, open in browser
                                        // ignore: avoid_print
                                        print('Tapped link: $href');
                                      }
                                    },
                                  ),
                                )
                                : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
