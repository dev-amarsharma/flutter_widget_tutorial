import 'package:flutter/material.dart';
import '../models/catalog_section.dart';
import '../services/catalog_service.dart';
import '../services/app_share_service.dart';
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

  @override
  void initState() {
    super.initState();
    _sectionsFuture = catalogService.loadCatalogSections();
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
      backgroundColor: Colors.grey.shade50,
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
            tooltip: 'Share app',
            onPressed: () {
              appShareService.shareApp(
                context,
                extraText: 'Track your Flutter learning progress with quizzes and lessons.',
              );
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
