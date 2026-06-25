import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'models/catalog_section.dart';
import 'models/quiz_question.dart';
import 'screens/quiz_screen.dart' show QuizScreen, QuizResult;
import 'services/achievement_service.dart';
import 'services/catalog_service.dart';
import 'services/app_config_service.dart';
import 'services/daily_challenge_service.dart';
import 'services/performance_service.dart';
import 'services/lesson_of_day_service.dart';
import 'services/rewarded_ad_service.dart';
import 'widgets/custom_dialog.dart';
import 'widgets/native_ad_widget.dart';

class WidgetCatalogPage extends StatefulWidget {
  final void Function(CatalogItem item) onOpenWidget;
  final VoidCallback onClear;

  const WidgetCatalogPage({
    Key? key,
    required this.onOpenWidget,
    required this.onClear,
  }) : super(key: key);

  @override
  State<WidgetCatalogPage> createState() => _WidgetCatalogPageState();
}

class _WidgetCatalogPageState extends State<WidgetCatalogPage> {
  late ScrollController _scrollController;
  late TextEditingController _searchController;
  List<CatalogSection> _catalogSections = const [];
  bool _isLoadingCatalog = true;
  String? _catalogLoadError;
  Timer? _saveTimer;
  String _searchQuery = '';
  bool _showBookmarksOnly = false;
  CatalogItem? _lessonOfDay;
  bool _dailyChallengeCompleted = false;
  static const _prefsScrollKey = 'catalog_scroll_offset';

  /// Load all quiz questions from widgets in a category
  Future<List<QuizQuestion>> _loadCategoryQuizQuestions(
    List<CatalogItem> items,
  ) async {
    final List<QuizQuestion> allQuestions = [];

    for (final item in items) {
      final quizPath = item.quizAssetPath;

      try {
        // Try to load the quiz file
        final quizData = await rootBundle.loadString(quizPath);
        final List<dynamic> jsonList = jsonDecode(quizData);
        final questions = QuizQuestion.fromJsonList(jsonList);
        allQuestions.addAll(questions);
      } catch (e) {
        // Quiz file doesn't exist for this widget, skip it
        // ignore: avoid_print
        print('Quiz file not found: $quizPath');
      }
    }

    return allQuestions;
  }

  /// Check internet connectivity
  Future<bool> _checkConnectivity() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      print('Error checking connectivity: $e');
      return false;
    }
  }

  /// Start quiz for a category
  Future<void> _startCategoryQuiz(
    BuildContext context,
    CatalogSection section,
  ) async {
    final items = section.items;
    final categoryName = section.title;

    // Check internet connectivity first
    if (!mounted) return;
    final hasInternet = await _checkConnectivity();

    if (!hasInternet) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No internet connection. Please check your connection and try again.',
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    // Show loading indicator
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => const CustomDialog(
            title: 'Loading Quiz',
            message: 'Please wait while we prepare your questions...',
            showCloseButton: false,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CircularProgressIndicator(color: Colors.deepOrange),
            ),
          ),
    );

    try {
      // Load rewarded ad before starting quiz
      String? adError;

      await rewardedAdService.loadRewardedAd(
        onAdFailed: (error) {
          adError = error;
        },
      );

      // Wait a bit for ad to load
      await Future.delayed(const Duration(seconds: 2));

      // Load all quiz questions from the category
      final questions = await _loadCategoryQuizQuestions(items);

      if (!mounted) return;
      Navigator.of(context).pop(); // Close loading dialog

      if (questions.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No quiz questions available for $categoryName'),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 3),
          ),
        );
        return;
      }

      // Show ad loading error if applicable
      if (adError != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Content loading failed. Please try after some time.',
            ),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 3),
          ),
        );
      }

      // Navigate to quiz screen
      if (!mounted) return;
      final result = await Navigator.of(context).push<QuizResult>(
        MaterialPageRoute(
          builder:
              (context) => QuizScreen(
                questions: questions,
                timerDurationSeconds: 30,
                quizTitle: categoryName,
              ),
        ),
      );

      // Show result summary
      if (result != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Quiz completed! Score: ${result.score} (${result.correctAnswers}/${result.totalQuestions} correct)',
            ),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop(); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading quiz: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _startDailyChallenge(BuildContext context) async {
    if (_dailyChallengeCompleted) return;

    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => const CustomDialog(
            title: 'Loading Challenge',
            message: 'Preparing your daily questions...',
            showCloseButton: false,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CircularProgressIndicator(color: Colors.deepOrange),
            ),
          ),
    );

    try {
      await rewardedAdService.loadRewardedAd(onAdFailed: (_) {});
      await Future.delayed(const Duration(seconds: 1));

      final questions = await dailyChallengeService.loadQuestions(
        _catalogSections,
      );

      if (!mounted) return;
      Navigator.of(context).pop();

      if (questions.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No challenge questions available today.'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      if (!mounted) return;
      final result = await Navigator.of(context).push<QuizResult>(
        MaterialPageRoute(
          builder:
              (context) => QuizScreen(
                questions: questions,
                timerDurationSeconds: dailyChallengeTimerSeconds,
                quizTitle: 'Daily Challenge',
              ),
        ),
      );

      if (result != null && mounted) {
        final bonusXp = await dailyChallengeService.markCompleted();
        await performanceService.addBonusXp(bonusXp);

        final newly = await achievementService.checkAndUnlock(
          readCount: performanceService.readAssets.length,
          streakCount: performanceService.streakCount,
          totalXp: performanceService.totalXp,
          level: performanceService.level,
          quizScores: performanceService.quizScores,
          dailyChallengeCompleted: true,
        );

        if (!mounted) return;
        setState(() => _dailyChallengeCompleted = true);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Daily challenge done! +$bonusXp XP  '
              '(${result.correctAnswers}/${result.totalQuestions} correct)',
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
          ),
        );

        for (final a in newly) {
          if (!mounted) break;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(a.icon, color: a.color, size: 20),
                  const SizedBox(width: 8),
                  Text('Achievement unlocked: ${a.name}!'),
                ],
              ),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading daily challenge: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchController = TextEditingController();
    _scrollController.addListener(_onScroll);
    _loadCatalogSections();
    _loadScrollOffset();
  }

  Future<void> _loadCatalogSections() async {
    try {
      final sections = await catalogService.loadCatalogSections();
      if (!mounted) return;
      final lotd = await lessonOfDayService.getLessonOfDay(
        sections,
        isRead: performanceService.isRead,
      );
      if (!mounted) return;
      setState(() {
        _catalogSections = sections;
        _lessonOfDay = lotd;
        _dailyChallengeCompleted = dailyChallengeService.isCompletedToday;
        _isLoadingCatalog = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _catalogLoadError = '$e';
        _isLoadingCatalog = false;
      });
    }
  }

  void _onScroll() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 400), () {
      _saveScrollOffset();
    });
  }

  Future<void> _loadScrollOffset() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final double? offset = prefs.getDouble(_prefsScrollKey);
      if (offset != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            final max = _scrollController.position.maxScrollExtent;
            final pos = offset.clamp(0.0, max);
            _scrollController.jumpTo(pos);
          }
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error loading scroll offset: $e');
    }
  }

  Future<void> _saveScrollOffset() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_prefsScrollKey, _scrollController.offset);
    } catch (e) {
      // ignore: avoid_print
      print('Error saving scroll offset: $e');
    }
  }

  @override
  void dispose() {
    _saveTimer?.cancel();
    _saveScrollOffset();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  bool _matchesFilters(CatalogItem item) {
    if (_showBookmarksOnly &&
        !performanceService.isBookmarked(
          topicId: item.topicId,
          assetPath: item.assetPath,
        )) {
      return false;
    }
    final query = _searchQuery.trim().toLowerCase();
    return query.isEmpty ||
        item.name.toLowerCase().contains(query) ||
        item.category.toLowerCase().contains(query) ||
        item.type.toLowerCase().contains(query) ||
        item.level.toLowerCase().contains(query) ||
        (item.description?.toLowerCase().contains(query) ?? false);
  }

  List<CatalogSection> get _filteredSections {
    return _catalogSections
        .map(
          (section) => CatalogSection(
            title: section.title,
            description: section.description,
            level: section.level,
            items: section.items.where(_matchesFilters).toList(),
          ),
        )
        .where((section) => section.items.isNotEmpty)
        .toList();
  }

  List<CatalogItem> get _continueLearningItems {
    final seenIds = <String>{};
    final items = <CatalogItem>[];

    for (final section in _catalogSections) {
      for (final item in section.items) {
        final key = item.topicId ?? item.assetPath;
        if (!seenIds.add(key) || item.isLegacy) {
          continue;
        }
        final isRead = performanceService.isRead(
          topicId: item.topicId,
          assetPath: item.assetPath,
        );
        final prerequisitesMet = item.prerequisites.every(
          (topicId) =>
              performanceService.isRead(topicId: topicId, assetPath: ''),
        );
        if (!isRead && prerequisitesMet && _matchesFilters(item)) {
          items.add(item);
        }
      }
    }

    return items.take(6).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSections = _filteredSections;
    final continueLearning = _continueLearningItems;
    final appConfig = appConfigService.config;

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 140,
          backgroundColor: Colors.deepOrange[400],
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
            title: Text(
              appConfig.catalogTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.1,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(1, 2),
                  ),
                ],
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepOrange[400]!.withOpacity(0.85),
                        Colors.orange[200]!.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ],
            ),
            stretchModes: const [
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
          ),
          stretch: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search topics, categories, or learning types',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon:
                        _searchQuery.isEmpty
                            ? null
                            : IconButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                              icon: const Icon(Icons.close),
                            ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Search by topic, category, level, or type.',
                  style: TextStyle(fontSize: 12, color: Colors.brown[400]),
                ),
                if (performanceService.streakCount > 0) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.deepOrange.shade400,
                          Colors.orange.shade300,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          performanceService.streakCount == 1
                              ? '1 day streak — keep it up!'
                              : '${performanceService.streakCount}-day streak — on fire!',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                GestureDetector(
                  onTap:
                      () => setState(() {
                        _showBookmarksOnly = !_showBookmarksOnly;
                      }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color:
                          _showBookmarksOnly
                              ? Colors.pink.shade400
                              : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            _showBookmarksOnly
                                ? Colors.pink.shade400
                                : Colors.pink.shade200,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _showBookmarksOnly
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              _showBookmarksOnly
                                  ? Colors.white
                                  : Colors.pink.shade400,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Bookmarks'
                          '${performanceService.bookmarks.isEmpty ? '' : ' (${performanceService.bookmarks.length})'}',
                          style: TextStyle(
                            color:
                                _showBookmarksOnly
                                    ? Colors.white
                                    : Colors.pink.shade400,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_lessonOfDay != null)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        color: Color(0xFF7C3AED),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Lesson of the Day',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7C3AED),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () => widget.onOpenWidget(_lessonOfDay!),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7C3AED), Color(0xFF4F46E5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF7C3AED).withOpacity(0.3),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildMetaBadge(_lessonOfDay!.level),
                                  const SizedBox(height: 8),
                                  Text(
                                    _lessonOfDay!.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${_lessonOfDay!.category} • ${_lessonOfDay!.type}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 12,
                                    ),
                                  ),
                                  if (_lessonOfDay!.estimatedMinutes != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        '${_lessonOfDay!.estimatedMinutes} min lesson',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 18,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Start',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (!_isLoadingCatalog && _catalogLoadError == null)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.bolt,
                        color: Color(0xFFFF6F00),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Daily Challenge',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF6F00),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap:
                        _dailyChallengeCompleted
                            ? null
                            : () => _startDailyChallenge(context),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors:
                              _dailyChallengeCompleted
                                  ? [Colors.grey.shade400, Colors.grey.shade500]
                                  : [
                                    const Color(0xFFFF6F00),
                                    const Color(0xFFFF8F00),
                                  ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: (_dailyChallengeCompleted
                                    ? Colors.grey
                                    : const Color(0xFFFF6F00))
                                .withOpacity(0.3),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _dailyChallengeCompleted
                                    ? Icons.check_circle
                                    : Icons.bolt,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _dailyChallengeCompleted
                                        ? 'Completed for today!'
                                        : '5 Questions · 20s each',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _dailyChallengeCompleted
                                        ? 'Come back tomorrow for a new challenge'
                                        : '+50 XP bonus · Resets at midnight',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!_dailyChallengeCompleted)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 18,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Start',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (continueLearning.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Continue Learning',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF795548),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 168,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: continueLearning.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final item = continueLearning[index];
                        return SizedBox(
                          width: 240,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: () => widget.onOpenWidget(item),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.deepOrange.shade300,
                                    Colors.orange.shade200,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildMetaBadge(item.level),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: Text(
                                        item.name,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${item.category} • ${item.type}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 12,
                                      ),
                                    ),
                                    if (item.estimatedMinutes != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          '${item.estimatedMinutes} min lesson',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                              0.95,
                                            ),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          sliver:
              _isLoadingCatalog
                  ? const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  )
                  : _catalogLoadError != null
                  ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Center(
                        child: Text(
                          'Failed to load catalog: $_catalogLoadError',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                  : filteredSections.isEmpty
                  ? const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: Text(
                          'No topics match the current search and filters.',
                        ),
                      ),
                    ),
                  )
                  : _buildCatalogSliver(filteredSections),
        ),
      ],
    );
  }

  /// Builds a flat list interleaving section cards with native ads every 3
  /// sections. Returns a [SliverList] ready to drop into a [CustomScrollView].
  Widget _buildCatalogSliver(List<CatalogSection> sections) {
    // Build items: CatalogSection or null (ad slot)
    final items = <Object?>[];
    for (int i = 0; i < sections.length; i++) {
      items.add(sections[i]);
      if ((i + 1) % 3 == 0 && i + 1 < sections.length) {
        items.add(null);
      }
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final item = items[index];
        if (item == null) return const NativeAdWidget();

        final section = item as CatalogSection;
        final readCount =
            section.items
                .where(
                  (item) => performanceService.isRead(
                    topicId: item.topicId,
                    assetPath: item.assetPath,
                  ),
                )
                .length;
        return Card(
          color: Colors.orange[50],
          elevation: 6,
          margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepOrange[400]!,
                            Colors.orange[200]!,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepOrange.withOpacity(0.18),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const Icon(
                        Icons.category,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            section.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF795548),
                              letterSpacing: 0.7,
                            ),
                          ),
                          if (section.description != null &&
                              section.description!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                section.description!,
                                style: TextStyle(
                                  color: Colors.brown[400],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          if (section.level != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: _buildSectionBadge(section.level!),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$readCount/${section.items.length} read',
                        style: TextStyle(
                          color: Colors.deepOrange[400],
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children:
                      section.items.map<Widget>((item) {
                        final isRead = performanceService.isRead(
                          topicId: item.topicId,
                          assetPath: item.assetPath,
                        );
                        final isBookmarked = performanceService.isBookmarked(
                          topicId: item.topicId,
                          assetPath: item.assetPath,
                        );
                        return InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () => widget.onOpenWidget(item),
                          child: Ink(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isRead ? Colors.green[100] : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color:
                                    isRead
                                        ? Colors.green.shade200
                                        : Colors.orange.shade100,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      isRead
                                          ? Icons.check_circle
                                          : Icons.menu_book_rounded,
                                      color:
                                          isRead
                                              ? Colors.green
                                              : Colors.deepOrange,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              isRead
                                                  ? Colors.green[900]
                                                  : Colors.brown[900],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () async {
                                        await performanceService.toggleBookmark(
                                          item.assetPath,
                                          topicId: item.topicId,
                                        );
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Icon(
                                          isBookmarked
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.pink.shade300,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: [
                                    _buildTopicBadge(
                                      item.level,
                                      Colors.deepOrange,
                                    ),
                                    _buildTopicBadge(
                                      item.category,
                                      Colors.brown,
                                    ),
                                    _buildTopicBadge(item.type, Colors.teal),
                                  ],
                                ),
                                if (item.estimatedMinutes != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      '${item.estimatedMinutes} min',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.brown[400],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _startCategoryQuiz(context, section),
                    icon: const Icon(Icons.quiz, size: 20),
                    label: const Text(
                      'Start Quiz (40 Questions)',
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
              ],
            ),
          ),
        );
      }, childCount: items.length),
    );
  }

  Widget _buildMetaBadge(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildSectionBadge(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: Colors.deepOrange.shade700,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildTopicBadge(String value, MaterialColor color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: color.shade700,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
