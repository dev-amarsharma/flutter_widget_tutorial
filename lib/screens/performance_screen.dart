import 'package:flutter/material.dart';
import '../services/performance_service.dart';
import '../widget_catalog_page.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({Key? key}) : super(key: key);

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  @override
  Widget build(BuildContext context) {
    final readAssets = performanceService.readAssets;
    final quizScores = performanceService.quizScores;
    
    // Calculate total stats
    int totalWidgets = 0;
    int readCount = 0;
    int attemptedQuizzes = 0;
    int totalScore = 0;

    for (final category in WidgetCatalogPage.catalog) {
      final widgets = category['widgets'] as List<Map<String, dynamic>>;
      totalWidgets += widgets.length;
      for (final widget in widgets) {
        final asset = widget['asset'] as String;
        if (readAssets.contains(asset)) {
          readCount++;
        }
        if (quizScores.containsKey(asset)) {
          attemptedQuizzes++;
          totalScore += quizScores[asset]!;
        }
      }
    }

    final double averageScore = attemptedQuizzes > 0 ? totalScore / attemptedQuizzes : 0;
    final double readProgress = totalWidgets > 0 ? readCount / totalWidgets : 0;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Card
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
            
            // Categories List
            ...WidgetCatalogPage.catalog.map((category) {
              return _buildCategorySection(category, readAssets, quizScores);
            }).toList(),
          ],
        ),
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
    Map<String, dynamic> category,
    Set<String> readAssets,
    Map<String, int> quizScores,
  ) {
    final widgets = category['widgets'] as List<Map<String, dynamic>>;
    final categoryName = category['category'] as String;
    
    // Calculate category specific stats
    int catReadCount = 0;
    int catTotalWidgets = widgets.length;
    for (final widget in widgets) {
      if (readAssets.contains(widget['asset'])) {
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
            final asset = widget['asset'] as String;
            final isRead = readAssets.contains(asset);
            final score = quizScores[asset];

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
                  widget['name'] as String,
                  style: TextStyle(
                    fontWeight: isRead ? FontWeight.w600 : FontWeight.normal,
                    color: isRead ? Colors.black87 : Colors.black54,
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
}
