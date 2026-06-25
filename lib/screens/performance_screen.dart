import 'package:flutter/material.dart';
import '../models/catalog_section.dart';
import '../services/achievement_service.dart';
import '../services/analytics_service.dart';
import '../services/catalog_service.dart';
import '../services/app_share_service.dart';
import '../services/app_config_service.dart';
import '../services/performance_service.dart';
import '../widgets/banner_ad_widget.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({Key? key}) : super(key: key);

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  late Future<List<CatalogSection>> _sectionsFuture;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  int _totalLessons = 0;
  int _readLessons = 0;
  int _avgScore = 0;

  @override
  void initState() {
    super.initState();
    _sectionsFuture = catalogService.loadCatalogSections().then((sections) {
      int total = 0, read = 0, scoreSum = 0, scoreCount = 0;
      for (final section in sections) {
        for (final item in section.items) {
          total++;
          if (performanceService.isRead(
            topicId: item.topicId,
            assetPath: item.assetPath,
          )) read++;
          final score = performanceService.getQuizScore(
            topicId: item.topicId,
            assetPath: item.assetPath,
          );
          if (score != null) {
            scoreCount++;
            scoreSum += score;
          }
        }
      }
      if (mounted) {
        setState(() {
          _totalLessons = total;
          _readLessons = read;
          _avgScore = scoreCount > 0 ? scoreSum ~/ scoreCount : 0;
        });
      }
      return sections;
    });
    analyticsService.logScreenView('performance');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool _matchesFilters(CatalogItem item) {
    final query = _searchQuery.trim().toLowerCase();
    return query.isEmpty ||
        item.name.toLowerCase().contains(query) ||
        item.category.toLowerCase().contains(query) ||
        item.level.toLowerCase().contains(query) ||
        item.type.toLowerCase().contains(query) ||
        (item.description?.toLowerCase().contains(query) ?? false);
  }

  List<CatalogSection> _filterSections(List<CatalogSection> sections) {
    return sections
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: const SafeArea(
        top: false,
        child: BannerAdWidget(),
      ),
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'My Performance',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.orange.shade400, // Matches QuizScreen primary color logic
                Colors.deepOrange.shade600,
              ],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            tooltip: 'Share progress',
            onPressed: () {
              final readPct = _totalLessons > 0
                  ? (_readLessons / _totalLessons * 100).round()
                  : 0;
              final streak = performanceService.streakCount;
              final levelName = performanceService.levelName;
              final extra = StringBuffer(
                'I\'ve completed $readPct% of ${appConfigService.config.appName} lessons'
                ' ($_readLessons/$_totalLessons)',
              );
              if (_avgScore > 0) extra.write(' with an avg quiz score of $_avgScore%');
              if (streak > 0) extra.write('. $streak-day learning streak');
              extra.write('. Level: $levelName. Can you keep up?');
              appShareService.shareApp(context, extraText: extra.toString());
            },
          ),
        ],
      ),
      body: FutureBuilder<List<CatalogSection>>(
        future: _sectionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Failed to load progress data: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final sections = snapshot.data ?? const <CatalogSection>[];
          final filteredSections = _filterSections(sections);
          int totalWidgets = 0;
          int readCount = 0;
          int attemptedQuizzes = 0;
          int totalScore = 0;

          for (final section in filteredSections) {
            totalWidgets += section.items.length;
            for (final item in section.items) {
              if (performanceService.isRead(
                topicId: item.topicId,
                assetPath: item.assetPath,
              )) {
                readCount++;
              }
              final score = performanceService.getQuizScore(
                topicId: item.topicId,
                assetPath: item.assetPath,
              );
              if (score != null) {
                attemptedQuizzes++;
                totalScore += score;
              }
            }
          }

          final averageScore =
              attemptedQuizzes > 0 ? totalScore / attemptedQuizzes : 0.0;
          final readProgress = totalWidgets > 0 ? readCount / totalWidgets : 0.0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.shade400,
                        Colors.purple.shade400,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text(
                          'Overall Progress',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(
                              'Reading Progress',
                              '${(readProgress * 100).toInt()}%',
                              '$readCount / $totalWidgets',
                              Icons.menu_book,
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: Colors.white24,
                            ),
                            _buildStatItem(
                              'Avg Quiz Score',
                              '${averageScore.toInt()}%',
                              'Attempted: $attemptedQuizzes',
                              Icons.emoji_events,
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: Colors.white24,
                            ),
                            _buildStatItem(
                              'Day Streak',
                              '${performanceService.streakCount}',
                              performanceService.streakCount == 1
                                  ? 'day'
                                  : 'days',
                              Icons.local_fire_department,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                _buildXpLevelCard(),
                _buildAchievementsSection(),
                const Padding(
                  padding: EdgeInsets.only(left: 4, bottom: 16),
                  child: Text(
                    'Detailed Progress',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                _buildSearchAndFilters(
                  topicCount: filteredSections.fold<int>(
                    0,
                    (sum, section) => sum + section.items.length,
                  ),
                ),
                const SizedBox(height: 8),
                if (filteredSections.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'No progress entries match the current search and filters.',
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  ...filteredSections.map((section) {
                    return _buildCategorySection(section);
                  }),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildXpLevelCard() {
    final level = performanceService.level;
    final levelName = performanceService.levelName;
    final totalXp = performanceService.totalXp;
    final progress = performanceService.levelProgress;
    final xpToNext = performanceService.xpToNextLevel;
    final isMaxLevel = level >= xpThresholds.length - 1;

    final levelColors = [
      [Colors.grey.shade400, Colors.grey.shade600],
      [Colors.green.shade400, Colors.green.shade700],
      [Colors.blue.shade400, Colors.blue.shade700],
      [Colors.purple.shade400, Colors.purple.shade700],
      [Colors.orange.shade400, Colors.deepOrange.shade600],
      [Colors.amber.shade400, Colors.red.shade600],
    ];
    final colors = levelColors[level.clamp(0, levelColors.length - 1)];

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors[0], colors[1]],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors[0].withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.military_tech,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        levelName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$totalXp XP total',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Lv. $level',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white.withOpacity(0.25),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isMaxLevel
                  ? 'Max level reached!'
                  : '$xpToNext XP to ${levelNames[(level + 1).clamp(0, levelNames.length - 1)]}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.military_tech, color: Colors.amber, size: 22),
              const SizedBox(width: 8),
              const Text(
                'Achievements',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Text(
                '${achievementService.unlockedIds.length}/${allAchievements.length}',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: allAchievements.map((a) {
              final unlocked = achievementService.isUnlocked(a.id);
              return Tooltip(
                message: a.description,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: unlocked
                            ? a.color.withOpacity(0.15)
                            : Colors.grey.shade100,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: unlocked
                              ? a.color.withOpacity(0.5)
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        unlocked ? a.icon : Icons.lock_outline,
                        color: unlocked ? a.color : Colors.grey.shade400,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 60,
                      child: Text(
                        a.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color:
                              unlocked ? Colors.black87 : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String mainValue, String subValue, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 12),
        Text(
          mainValue,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.9)),
        ),
        const SizedBox(height: 2),
        Text(
          subValue,
          style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.7)),
        ),
      ],
    );
  }

  Widget _buildCategorySection(
    CatalogSection category,
  ) {
    final widgets = category.items;
    final categoryName = category.title;
    
    // Calculate category specific stats
    int catReadCount = 0;
    int catTotalWidgets = widgets.length;
    for (final widget in widgets) {
      if (performanceService.isRead(
        topicId: widget.topicId,
        assetPath: widget.assetPath,
      )) {
        catReadCount++;
      }
    }
    final double catProgress = catTotalWidgets > 0 ? catReadCount / catTotalWidgets : 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ExpansionTile(
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          childrenPadding: const EdgeInsets.only(bottom: 12),
          title: Text(
            categoryName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${(catProgress * 100).toInt()}% Completed',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      '$catReadCount/$catTotalWidgets',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: catProgress,
                    backgroundColor: Colors.grey.shade100,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      catProgress == 1.0 ? Colors.green : Colors.orange,
                    ),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
          children: widgets.map((widget) {
            final asset = widget.assetPath;
            final isRead = performanceService.isRead(
              topicId: widget.topicId,
              assetPath: asset,
            );
            final score = performanceService.getQuizScore(
              topicId: widget.topicId,
              assetPath: asset,
            );

            return Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade100),
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isRead 
                        ? Colors.green.shade50
                        : Colors.grey.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isRead ? Icons.check : Icons.article_outlined,
                    color: isRead ? Colors.green.shade600 : Colors.grey.shade400,
                    size: 20,
                  ),
                ),
                title: Text(
                  widget.name,
                  style: TextStyle(
                    fontWeight: isRead ? FontWeight.w600 : FontWeight.normal,
                    color: isRead ? Colors.black87 : Colors.black54,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _buildChip(widget.level, Colors.deepOrange),
                      _buildChip(widget.category, Colors.brown),
                      _buildChip(widget.type, Colors.teal),
                    ],
                  ),
                ),
                trailing: score != null 
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getScoreColor(score).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _getScoreColor(score).withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        '$score%',
                        style: TextStyle(
                          color: _getScoreColor(score),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.green.shade600;
    if (score >= 50) return Colors.orange.shade600;
    return Colors.red.shade600;
  }

  Widget _buildSearchAndFilters({
    required int topicCount,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
              hintText: 'Search topics, categories, or levels',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isEmpty
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
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            '$topicCount topics in view',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String value, MaterialColor color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color.shade700,
        ),
      ),
    );
  }
}
