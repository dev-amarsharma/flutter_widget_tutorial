import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'dart:convert';
import 'widgets/banner_ad_widget.dart';
import 'services/interstitial_ad_service.dart';
import 'services/rewarded_ad_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'models/quiz_question.dart';
import 'models/topic_manifest.dart';
import 'screens/quiz_screen.dart' show QuizScreen, QuizResult;
import 'services/performance_service.dart';
import 'services/app_share_service.dart';
import 'services/app_config_service.dart';
import 'services/topics_manifest_repository.dart';

class WidgetPreviewPage extends StatefulWidget {
  final String assetPath;
  final String? quizAssetPath;
  final String? topicId;
  final String? title;
  final void Function(String assetPath, {String? topicId}) onMarkAsRead;

  const WidgetPreviewPage({
    Key? key,
    required this.assetPath,
    this.quizAssetPath,
    this.topicId,
    this.title,
    required this.onMarkAsRead,
  }) : super(key: key);

  @override
  State<WidgetPreviewPage> createState() => _WidgetPreviewPageState();
}

class _WidgetPreviewPageState extends State<WidgetPreviewPage> {
  String? _markdownData;
  bool _hasQuiz = false;
  TopicMetadata? _topicMetadata;
  List<TopicMetadata> _prerequisiteTopics = const [];
  List<TopicMetadata> _relatedTopics = const [];

  @override
  void initState() {
    super.initState();
    _loadTopicMetadata();
    _loadMarkdown();
    _checkQuizExists();
    // Track navigation for interstitial ad
    interstitialAdService.handleWidgetPageNavigation();
    // Load rewarded ad
    rewardedAdService.loadRewardedAd();
  }

  Future<void> _loadTopicMetadata() async {
    TopicMetadata? topic;
    if (widget.topicId != null) {
      topic = await topicsManifestRepository.findTopicById(widget.topicId!);
    } else {
      topic =
          await topicsManifestRepository.findTopicByLessonAsset(widget.assetPath);
    }

    final prerequisiteTopics = topic == null
        ? const <TopicMetadata>[]
        : await topicsManifestRepository.findTopicsByIds(topic.prerequisites);
    final relatedTopics = topic == null
        ? const <TopicMetadata>[]
        : await topicsManifestRepository.findTopicsByIds(topic.relatedTopicIds);

    if (!mounted) return;
    setState(() {
      _topicMetadata = topic;
      _prerequisiteTopics = prerequisiteTopics;
      _relatedTopics = relatedTopics;
    });
    await _checkQuizExists();
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
      final quizPath = _resolvedQuizAssetPath;
      
      // Try to load the quiz file to check if it exists
      await rootBundle.loadString(quizPath);
      setState(() => _hasQuiz = true);
    } catch (e) {
      // Quiz file doesn't exist
      setState(() => _hasQuiz = false);
    }
  }

  bool _adShownAtStart = false;

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

    // Show interstitial ad before quiz starts
    // Use forceLoad: true to ensure ad is loaded if not already ready
    if (!interstitialAdService.isAdReady && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              ),
              SizedBox(width: 16),
              Text('Preparing quiz ...'),
            ],
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }

    _adShownAtStart = await interstitialAdService.showInterstitialAd(forceLoad: true);
    
    if (!_adShownAtStart && mounted) {
       print('Ad could not be shown, starting quiz anyway');
    }
    
    // Small delay after ad dismissal to ensure smooth transition
    await Future.delayed(const Duration(milliseconds: 300));

    if (!mounted) return;

    // Launch quiz
    _launchQuiz();
  }

  String get _resolvedQuizAssetPath {
    return widget.quizAssetPath ??
        _topicMetadata?.quizAsset ??
        '${widget.assetPath.replaceAll('.md', '')}_quiz.json';
  }

  Future<void> _launchQuiz() async {
    try {
      final quizPath = _resolvedQuizAssetPath;
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
            adShownAtStart: _adShownAtStart,
          ),
        ),
      );
      
      // Optionally show result summary
      if (result != null && mounted) {
        // Save score
        await performanceService.saveQuizScore(
          widget.assetPath,
          result.correctAnswers,
          result.totalQuestions,
          topicId: widget.topicId ?? _topicMetadata?.id,
        );

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

  Future<void> _openTopic(TopicMetadata topic) async {
    await interstitialAdService.handleWidgetPageNavigation();
    if (!mounted) return;

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WidgetPreviewPage(
          assetPath: topic.lessonAsset,
          quizAssetPath: topic.quizAsset,
          topicId: topic.id,
          title: topic.title,
          onMarkAsRead: widget.onMarkAsRead,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveTitle =
        widget.title ?? _topicMetadata?.title ?? widget.assetPath.split('/').last.replaceAll('.md', '');
    final isRead = performanceService.isRead(
      topicId: widget.topicId ?? _topicMetadata?.id,
      assetPath: widget.assetPath,
    );

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
      bottomNavigationBar: const SafeArea(
        top: false,
        child: BannerAdWidget(),
      ),
      appBar: AppBar(
        title: Text(effectiveTitle),
        backgroundColor:
            theme.appBarTheme.backgroundColor ?? theme.colorScheme.primary,
        titleTextStyle: theme.appBarTheme.titleTextStyle,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Share app',
            onPressed: () {
              appShareService.shareApp(
                context,
                extraText:
                    'I am learning "$effectiveTitle" in ${appConfigService.config.appName}.',
              );
            },
          ),
          IconButton(
            icon: Icon(isRead ? Icons.check_circle : Icons.check),
            tooltip: isRead ? 'Read' : 'Mark as read',
            onPressed:
                isRead
                    ? null
                    : () {
                        widget.onMarkAsRead(
                          widget.assetPath,
                          topicId: widget.topicId ?? _topicMetadata?.id,
                        );
                        setState(() {});
                      },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_topicMetadata != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: _buildTopicOverview(theme),
            ),
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
                                  quizAssetPath: null,
                                  topicId: null,
                                  title: null,
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
        ],
      ),
    );
  }

  Widget _buildTopicOverview(ThemeData theme) {
    final topic = _topicMetadata!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.orange.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildInfoChip(topic.level, Colors.deepOrange),
              _buildInfoChip(topic.category, Colors.brown),
              _buildInfoChip(topic.type, Colors.teal),
              _buildInfoChip(
                '${topic.estimatedMinutes} min',
                Colors.indigo,
              ),
            ],
          ),
          if (_prerequisiteTopics.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(
              'Prerequisites',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _prerequisiteTopics.map((prerequisite) {
                final isCompleted = performanceService.isRead(
                  topicId: prerequisite.id,
                  assetPath: prerequisite.lessonAsset,
                );
                return ActionChip(
                  avatar: Icon(
                    isCompleted ? Icons.check_circle : Icons.lock_open,
                    size: 16,
                    color: isCompleted
                        ? Colors.green.shade700
                        : Colors.orange.shade700,
                  ),
                  label: Text(prerequisite.title),
                  backgroundColor: isCompleted
                      ? Colors.green.shade50
                      : Colors.orange.shade50,
                  onPressed: () => _openTopic(prerequisite),
                );
              }).toList(),
            ),
          ],
          if (_relatedTopics.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(
              'Related Topics',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _relatedTopics.map((related) {
                return ActionChip(
                  avatar: const Icon(
                    Icons.auto_stories_rounded,
                    size: 16,
                  ),
                  label: Text(related.title),
                  backgroundColor: Colors.white,
                  onPressed: () => _openTopic(related),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoChip(String value, MaterialColor color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: color.shade700,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
