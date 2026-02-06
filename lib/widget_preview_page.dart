import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'dart:convert';
import 'widgets/banner_ad_widget.dart';
import 'services/interstitial_ad_service.dart';
import 'services/rewarded_ad_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'models/quiz_question.dart';
import 'screens/quiz_screen.dart' show QuizScreen, QuizResult;

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
  bool _hasQuiz = false;

  @override
  void initState() {
    super.initState();
    _loadMarkdown();
    _checkQuizExists();
    // Track navigation for interstitial ad
    interstitialAdService.handleWidgetPageNavigation();
    // Load rewarded ad
    rewardedAdService.loadRewardedAd();
  }

  Future<void> _loadMarkdown() async {
    try {
      final data = await rootBundle.loadString(widget.assetPath);
      setState(() => _markdownData = data);
    } catch (e) {
      setState(() => _markdownData = 'Error loading ${widget.assetPath}');
    }
  }

  Future<void> _checkQuizExists() async {
    try {
      // Convert asset path from assets/textview.md to assets/textview_quiz.json
      final basePath = widget.assetPath.replaceAll('.md', '');
      final quizPath = '${basePath}_quiz.json';
      
      // Try to load the quiz file to check if it exists
      await rootBundle.loadString(quizPath);
      setState(() => _hasQuiz = true);
    } catch (e) {
      // Quiz file doesn't exist
      setState(() => _hasQuiz = false);
    }
  }

  Future<void> _startQuiz() async {
    // Check internet connection
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please check your internet connection to attempt the quiz'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    // Check rewarded ad
    if (!rewardedAdService.isAdReady) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ad is loading... Please try again.'),
          ),
        );
        // Try to load again
        rewardedAdService.loadRewardedAd();
      }
      return;
    }

    // Launch quiz directly without showing ad
    _launchQuiz();
  }

  Future<void> _launchQuiz() async {
    try {
      final basePath = widget.assetPath.replaceAll('.md', '');
      final quizPath = '${basePath}_quiz.json';
      final quizData = await rootBundle.loadString(quizPath);
      
      // Parse JSON data
      final List<dynamic> jsonList = jsonDecode(quizData);
      final List<QuizQuestion> questions = QuizQuestion.fromJsonList(jsonList);
      
      if (questions.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No questions available in quiz file'),
              duration: Duration(seconds: 2),
            ),
          );
        }
        return;
      }
      
      // Navigate to quiz screen
      if (!mounted) return;
      
      final result = await Navigator.of(context).push<QuizResult>(
        MaterialPageRoute(
          builder: (context) => QuizScreen(
            questions: questions,
            timerDurationSeconds: 30,
          ),
        ),
      );
      
      // Optionally show result summary
      if (result != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Quiz completed! Score: ${result.score} (${result.correctAnswers}/${result.totalQuestions} correct)',
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading quiz: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
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
          // Start Quiz button (if quiz exists)
          if (_hasQuiz)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _startQuiz,
                  icon: const Icon(Icons.quiz, size: 20),
                  label: const Text(
                    'Start Quiz',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange[400],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
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
