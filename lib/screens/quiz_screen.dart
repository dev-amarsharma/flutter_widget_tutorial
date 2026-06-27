import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/quiz_question.dart';
import '../services/app_share_service.dart';
import '../services/app_config_service.dart';
import '../services/rewarded_ad_service.dart';
import '../services/interstitial_ad_service.dart';
import '../widgets/banner_ad_widget.dart';
import '../widgets/custom_dialog.dart';

/// Quiz result data class
class QuizResult {
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int remainingLives;
  final int score;

  QuizResult({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.remainingLives,
    required this.score,
  });
}

/// Main quiz screen widget
///
/// Features:
/// - Random selection of up to 40 questions from provided list
/// - Per-question countdown timer (default 30 seconds)
/// - 3 lives system (hearts/stars)
/// - Answer handling with visual feedback
/// - Reward video popup when lives are lost
/// - Result screen on completion
class QuizScreen extends StatefulWidget {
  /// List of quiz questions (can be more than 15)
  final List<QuizQuestion> questions;

  /// Optional: Custom timer duration per question (default: 30 seconds)
  final int timerDurationSeconds;

  /// Whether an ad was shown before starting the quiz
  final bool adShownAtStart;

  /// Optional title used in the share message (e.g. category name)
  final String? quizTitle;

  const QuizScreen({
    super.key,
    required this.questions,
    this.timerDurationSeconds = 30,
    this.adShownAtStart = false,
    this.quizTitle,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with TickerProviderStateMixin {
  // Quiz state
  late List<QuizQuestion> _selectedQuestions;
  int _currentQuestionIndex = 0;
  int _lives = 3;
  int _score = 0;
  int _correctCount = 0;
  int _wrongCount = 0;

  // Streak state
  int _streak = 0;
  int _bestStreak = 0;

  // Timer state
  Timer? _timer;
  int _timeRemaining = 30;
  bool _isAnswered = false;
  bool _isPaused = false;
  int? _selectedOptionIndex;
  bool _lastAnswerCorrect = false;

  // Animation
  late AnimationController _entranceController;
  late AnimationController _confettiController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _initializeQuiz();
  }

  /// Initialize quiz: randomize and select questions (up to available count)
  void _initializeQuiz() {
    final random = Random();
    final shuffled = List<QuizQuestion>.from(widget.questions)..shuffle(random);
    // Select up to the number of questions available, but prefer 40 if available
    final questionCount =
        widget.questions.length >= 40 ? 40 : widget.questions.length;
    _selectedQuestions = shuffled.take(questionCount).toList();
    _timeRemaining = widget.timerDurationSeconds;
    _startTimer();
  }

  /// Start the countdown timer for current question
  void _startTimer() {
    _timeRemaining = widget.timerDurationSeconds;
    _isAnswered = false;
    _selectedOptionIndex = null;

    // Replay the staggered entrance animation for the new question.
    _entranceController.forward(from: 0);

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _isPaused) return;

      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          // Time's up - treat as wrong answer
          _handleTimeout();
        }
      });
    });
  }

  /// Handle timeout: treat as wrong answer
  Future<void> _handleTimeout() async {
    if (_isAnswered) return;

    _timer?.cancel();
    _isAnswered = true;
    _wrongCount++;
    _lives--;
    _streak = 0;

    if (_lives <= 0) {
      await _showLivesLostDialog();
    } else {
      _moveToNextQuestion();
    }
  }

  /// Handle answer selection
  void _handleAnswer(int selectedIndex) {
    if (_isAnswered) return; // Prevent double-taps

    _timer?.cancel();
    _isAnswered = true;
    _selectedOptionIndex = selectedIndex;

    final question = _selectedQuestions[_currentQuestionIndex];
    final isCorrect = selectedIndex == question.ans;
    _lastAnswerCorrect = isCorrect;

    setState(() {
      if (isCorrect) {
        _correctCount++;
        _streak++;
        if (_streak > _bestStreak) _bestStreak = _streak;
        // Base points plus a small streak bonus to reward consecutive answers.
        final streakBonus = _streak >= 2 ? (_streak - 1) * 5 : 0;
        _score += 10 + streakBonus;
      } else {
        _wrongCount++;
        _lives--;
        _streak = 0;
      }
    });

    if (isCorrect) {
      _confettiController.forward(from: 0);
    }

    // Show visual feedback briefly before moving on
    Future.delayed(const Duration(milliseconds: 1500), () async {
      if (!mounted) return;

      if (_lives <= 0) {
        await _showLivesLostDialog();
      } else if (_currentQuestionIndex < _selectedQuestions.length - 1) {
        _moveToNextQuestion();
      } else {
        await _showResultScreen();
      }
    });
  }

  /// Move to next question
  Future<void> _moveToNextQuestion() async {
    if (_currentQuestionIndex < _selectedQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      _startTimer();
    } else {
      await _showResultScreen();
    }
  }

  /// Show dialog when all lives are lost
  Future<void> _showLivesLostDialog() async {
    _isPaused = true;

    // If no ad was shown at the start, show one now before the lives lost dialog
    if (!widget.adShownAtStart) {
      await interstitialAdService.showInterstitialAd(forceLoad: true);
      // Small delay after ad dismissal
      await Future.delayed(const Duration(milliseconds: 300));
    }

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (context) => CustomDialog(
        title: 'Better Luck Next Time!',
        message: 'You\'ve run out of lives!\nWatch a reward video to continue.',
        icon: Icons.sentiment_dissatisfied,
        iconColor: Colors.white,
        gradientColors: [
          Colors.red.shade400,
          Colors.orange.shade400,
        ],
        primaryButtonText: 'Watch Ad',
        onPrimaryPressed: () {
          Navigator.of(context).pop();
          _watchRewardVideo();
        },
        secondaryButtonText: 'Exit',
        onSecondaryPressed: () {
          Navigator.of(context).pop();
          _exitQuiz();
        },
      ),
    );
  }

  /// Watch reward video and grant +1 life
  /// Uses AdMob rewarded ad service
  Future<void> _watchRewardVideo() async {
    if (!mounted) return;

    // Check if ad is ready
    if (!rewardedAdService.isAdReady) {
      // Try to load ad first
      await rewardedAdService.loadRewardedAd(
        onAdFailed: (error) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Content loading failed. Please try after some time.'),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 3),
            ),
          );
        },
      );
      await Future.delayed(const Duration(seconds: 2));

      if (!rewardedAdService.isAdReady) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Content loading failed. Please try after some time.'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }
    }

    // Show rewarded ad with callbacks
    final adShown = await rewardedAdService.showRewardedAd(
      onRewardEarned: (reward) {
        if (!mounted) return;
        setState(() {
          _lives = 1; // Grant 1 life
          _isPaused = false;
        });

        // Resume quiz from next question
        _moveToNextQuestion();
      },
      onAdDismissed: () {
        // Ad was dismissed without reward
        if (!mounted) return;
        if (_lives <= 0) {
          _exitQuiz();
        }
      },
      onAdFailed: (error) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Content loading failed. Please try after some time.'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 3),
          ),
        );
        if (_lives <= 0) {
          _exitQuiz();
        }
      },
    );

    if (!adShown) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Content loading failed. Please try after some time.'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  /// Exit quiz and return result
  Future<void> _exitQuiz() async {
    _timer?.cancel();

    if (!mounted) return;

    final result = QuizResult(
      totalQuestions: _selectedQuestions.length,
      correctAnswers: _correctCount,
      wrongAnswers: _wrongCount,
      remainingLives: _lives,
      score: _score,
    );
    Navigator.of(context).pop(result);
  }

  /// Show result screen/dialog
  Future<void> _showResultScreen() async {
    _timer?.cancel();
    _isPaused = true;

    // If no ad was shown at the start, show one now before the result screen
    if (!widget.adShownAtStart) {
      await interstitialAdService.showInterstitialAd(forceLoad: true);
      // Small delay after ad dismissal
      await Future.delayed(const Duration(milliseconds: 300));
    }

    if (!mounted) return;

    final result = QuizResult(
      totalQuestions: _selectedQuestions.length,
      correctAnswers: _correctCount,
      wrongAnswers: _wrongCount,
      remainingLives: _lives,
      score: _score,
    );

    final percentage =
        (result.correctAnswers / result.totalQuestions * 100).round();
    final isExcellent = percentage >= 80;
    final isGood = percentage >= 60;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (context) => CustomDialog(
        title: isExcellent
            ? 'Excellent!'
            : isGood
                ? 'Good Job!'
                : 'Quiz Complete!',
        icon: isExcellent
            ? Icons.emoji_events
            : isGood
                ? Icons.star
                : Icons.thumb_up,
        iconColor: Colors.white,
        gradientColors: isExcellent
            ? [Colors.green.shade400, Colors.teal.shade400]
            : isGood
                ? [Colors.blue.shade400, Colors.purple.shade400]
                : [Colors.orange.shade400, Colors.pink.shade400],
        primaryButtonText: 'Done',
        onPrimaryPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop(result);
        },
        child: Column(
          children: [
            Text(
              'Score: ${result.score}',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildResultRow(
                    Icons.help_outline,
                    'Total Questions',
                    '${result.totalQuestions}',
                    Colors.blue,
                  ),
                  const Divider(height: 24),
                  _buildResultRow(
                    Icons.check_circle,
                    'Correct',
                    '${result.correctAnswers}',
                    Colors.green,
                  ),
                  const Divider(height: 24),
                  _buildResultRow(
                    Icons.cancel,
                    'Wrong',
                    '${result.wrongAnswers}',
                    Colors.red,
                  ),
                  const Divider(height: 24),
                  _buildResultRow(
                    Icons.local_fire_department,
                    'Best Streak',
                    '$_bestStreak',
                    Colors.deepOrange,
                  ),
                  const Divider(height: 24),
                  _buildResultRow(
                    Icons.favorite,
                    'Remaining Lives',
                    '${result.remainingLives}',
                    Colors.pink,
                  ),
                  const Divider(height: 24),
                  _buildResultRow(
                    Icons.percent,
                    'Accuracy',
                    '$percentage%',
                    Colors.purple,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white, width: 1.5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.share, size: 18),
                label: const Text(
                  'Share Score',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  final title = widget.quizTitle ??
                      appConfigService.config.primaryTopic;
                  appShareService.shareApp(
                    context,
                    extraText: 'I scored $percentage% on the $title quiz! '
                        '(${result.correctAnswers}/${result.totalQuestions} correct) '
                        'Can you beat my score?',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _entranceController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  /// Builds a staggered fade+slide entrance for an item at [position] of [count].
  Widget _staggered(int position, int count, Widget child) {
    final double start = (0.15 + position * 0.12).clamp(0.0, 0.8);
    final double end = (start + 0.5).clamp(0.0, 1.0);
    final curved = CurvedAnimation(
      parent: _entranceController,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );
    return AnimatedBuilder(
      animation: curved,
      builder: (context, c) {
        return Opacity(
          opacity: curved.value,
          child: Transform.translate(
            offset: Offset(0, 24 * (1 - curved.value)),
            child: c,
          ),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedQuestions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              tooltip: 'Share app',
              onPressed: () {
                appShareService.shareApp(
                  context,
                  extraText:
                      'Practice ${appConfigService.config.primaryTopic} quizzes in this learning app.',
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: const SafeArea(
          top: false,
          child: BannerAdWidget(),
        ),
        body: const Center(
          child: Text('No questions available'),
        ),
      );
    }

    final question = _selectedQuestions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _selectedQuestions.length;
    final primary = Theme.of(context).colorScheme.primary;
    final bool lowTime = _timeRemaining <= 5;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;

        if (!mounted) return;
        final navigator = Navigator.of(context);

        // Show confirmation dialog before exiting
        final shouldExit = await showDialog<bool>(
          context: context,
          barrierColor: Colors.black54,
          builder: (context) => CustomDialog(
            title: 'Quit Quiz?',
            message:
                'Are you sure you want to quit? You\'ll lose your current progress.',
            icon: Icons.warning_amber_rounded,
            iconColor: Colors.orange,
            primaryButtonText: 'Quit',
            onPrimaryPressed: () => Navigator.of(context).pop(true),
            secondaryButtonText: 'Cancel',
            onSecondaryPressed: () => Navigator.of(context).pop(false),
          ),
        );

        if (shouldExit == true && mounted) {
          _timer?.cancel();
          navigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F5FB),
        bottomNavigationBar: const SafeArea(
          top: false,
          child: BannerAdWidget(),
        ),
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Question ${_currentQuestionIndex + 1}/${_selectedQuestions.length}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primary,
                  primary.withOpacity(0.8),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share, color: Colors.white),
              tooltip: 'Share app',
              onPressed: () {
                appShareService.shareApp(
                  context,
                  extraText:
                      'Practice ${appConfigService.config.primaryTopic} quizzes in this learning app.',
                );
              },
            ),
            // Lives display (hearts)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(3, (index) {
                  final bool active = index < _lives;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: AnimatedScale(
                      scale: active ? 1.0 : 0.85,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        active ? Icons.favorite : Icons.favorite_border,
                        color: active ? Colors.red.shade300 : Colors.white70,
                        size: 22,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
        body: _isPaused
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primary),
                ),
              )
            : Stack(
                children: [
                  Column(
                    children: [
                      // Animated gradient progress bar
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: progress),
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        builder: (context, value, _) {
                          return Container(
                            height: 8,
                            color: Colors.grey.shade200,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: value.clamp(0.0, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        primary,
                                        primary.withOpacity(0.6),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // Stats header: score | circular timer | streak
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: _StatChip(
                                icon: Icons.stars_rounded,
                                iconColor: Colors.amber.shade600,
                                label: 'Score',
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween(end: _score.toDouble()),
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOut,
                                  builder: (context, value, _) => Text(
                                    '${value.round()}',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1F2233),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            _CircularTimer(
                              timeRemaining: _timeRemaining,
                              total: widget.timerDurationSeconds,
                              lowTime: lowTime,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _StatChip(
                                icon: Icons.local_fire_department,
                                iconColor: _streak >= 2
                                    ? Colors.deepOrange
                                    : Colors.grey.shade400,
                                label: 'Streak',
                                child: AnimatedScale(
                                  scale: _streak >= 2 ? 1.15 : 1.0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOutBack,
                                  child: Text(
                                    '$_streak',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: _streak >= 2
                                          ? Colors.deepOrange
                                          : const Color(0xFF1F2233),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Question + options
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Question card (animated swap between questions)
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                transitionBuilder: (child, animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0.15, 0),
                                        end: Offset.zero,
                                      ).animate(CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeOutCubic,
                                      )),
                                      child: child,
                                    ),
                                  );
                                },
                                child: Container(
                                  key: ValueKey(_currentQuestionIndex),
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(22),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white,
                                        Color(0xFFF7F8FE),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primary.withOpacity(0.08),
                                        blurRadius: 16,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: primary.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'Q${_currentQuestionIndex + 1}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: primary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 14),
                                      Text(
                                        question.que,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1F2233),
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 22),

                              // Answer options (staggered entrance)
                              ...List.generate(question.options.length, (index) {
                                return _staggered(
                                  index,
                                  question.options.length,
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 14.0),
                                    child: _AnswerButton(
                                      option: question.options[index],
                                      index: index,
                                      correctIndex: question.ans,
                                      isAnswered: _isAnswered,
                                      selectedOptionIndex: _selectedOptionIndex,
                                      onTap: () => _handleAnswer(index),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Confetti burst overlay (correct answers)
                  if (_lastAnswerCorrect)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedBuilder(
                          animation: _confettiController,
                          builder: (context, _) {
                            if (_confettiController.isDismissed) {
                              return const SizedBox.shrink();
                            }
                            return CustomPaint(
                              painter: _ConfettiPainter(
                                progress: _confettiController.value,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}

/// Circular animated countdown ring shown in the stats header.
class _CircularTimer extends StatelessWidget {
  final int timeRemaining;
  final int total;
  final bool lowTime;

  const _CircularTimer({
    required this.timeRemaining,
    required this.total,
    required this.lowTime,
  });

  @override
  Widget build(BuildContext context) {
    final Color ringColor =
        lowTime ? Colors.red.shade500 : Theme.of(context).colorScheme.primary;
    final double target = total == 0 ? 0 : (timeRemaining / total);

    return TweenAnimationBuilder<double>(
      tween: Tween(end: target.clamp(0.0, 1.0)),
      duration: const Duration(milliseconds: 950),
      curve: Curves.linear,
      builder: (context, value, _) {
        return AnimatedScale(
          scale: lowTime ? 1.06 : 1.0,
          duration: const Duration(milliseconds: 300),
          child: SizedBox(
            width: 78,
            height: 78,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 78,
                  height: 78,
                  child: CircularProgressIndicator(
                    value: value,
                    strokeWidth: 7,
                    backgroundColor: ringColor.withOpacity(0.15),
                    valueColor: AlwaysStoppedAnimation<Color>(ringColor),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$timeRemaining',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                        color: ringColor,
                      ),
                    ),
                    Text(
                      'sec',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: ringColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Small rounded stat card used for Score and Streak.
class _StatChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Widget child;

  const _StatChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: iconColor),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          child,
        ],
      ),
    );
  }
}

/// Lightweight confetti burst painter (no external dependency).
class _ConfettiPainter extends CustomPainter {
  final double progress; // 0..1

  static final List<_Particle> _particles = _buildParticles();

  _ConfettiPainter({required this.progress});

  static List<_Particle> _buildParticles() {
    final rnd = Random(7);
    const colors = [
      Color(0xFFE53935),
      Color(0xFF8E24AA),
      Color(0xFF3949AB),
      Color(0xFF00ACC1),
      Color(0xFF43A047),
      Color(0xFFFFB300),
      Color(0xFFFF7043),
    ];
    return List.generate(48, (i) {
      final angle = rnd.nextDouble() * 2 * pi;
      final speed = 90 + rnd.nextDouble() * 230;
      return _Particle(
        angle: angle,
        speed: speed,
        color: colors[rnd.nextInt(colors.length)],
        size: 5 + rnd.nextDouble() * 7,
        rotation: rnd.nextDouble() * 2 * pi,
        rotationSpeed: (rnd.nextDouble() - 0.5) * 12,
      );
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    final origin = Offset(size.width / 2, size.height * 0.32);
    final paint = Paint();
    const gravity = 420.0;

    for (final p in _particles) {
      final t = progress;
      final dx = cos(p.angle) * p.speed * t;
      final dy =
          sin(p.angle) * p.speed * t + 0.5 * gravity * t * t;
      final pos = origin + Offset(dx, dy);

      // Fade out in the last 35% of the animation.
      final opacity = progress < 0.65 ? 1.0 : (1 - (progress - 0.65) / 0.35);
      paint.color = p.color.withOpacity(opacity.clamp(0.0, 1.0));

      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      canvas.rotate(p.rotation + p.rotationSpeed * t);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: p.size,
            height: p.size * 0.6,
          ),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _Particle {
  final double angle;
  final double speed;
  final Color color;
  final double size;
  final double rotation;
  final double rotationSpeed;

  _Particle({
    required this.angle,
    required this.speed,
    required this.color,
    required this.size,
    required this.rotation,
    required this.rotationSpeed,
  });
}

/// Answer option button widget
/// Shows visual feedback (green for correct, red for wrong)
class _AnswerButton extends StatefulWidget {
  final String option;
  final int index;
  final int correctIndex;
  final bool isAnswered;
  final int? selectedOptionIndex;
  final VoidCallback onTap;

  const _AnswerButton({
    required this.option,
    required this.index,
    required this.correctIndex,
    required this.isAnswered,
    required this.selectedOptionIndex,
    required this.onTap,
  });

  @override
  State<_AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<_AnswerButton>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
  }

  @override
  void didUpdateWidget(covariant _AnswerButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bool isSelected = widget.index == widget.selectedOptionIndex;
    final bool wrongPick =
        widget.isAnswered && isSelected && widget.index != widget.correctIndex;
    if (wrongPick && !oldWidget.isAnswered) {
      _shakeController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final optionLetters = ['A', 'B', 'C', 'D'];
    final primary = Theme.of(context).colorScheme.primary;
    late Color backgroundColor;
    late Color textColor;
    late Color borderColor;
    IconData? icon;

    final bool isSelected = widget.index == widget.selectedOptionIndex;
    final bool isCorrectOption = widget.index == widget.correctIndex;

    if (widget.isAnswered && isSelected) {
      if (isCorrectOption) {
        backgroundColor = Colors.green.shade500;
        textColor = Colors.white;
        borderColor = Colors.green.shade600;
        icon = Icons.check_circle;
      } else {
        backgroundColor = Colors.red.shade500;
        textColor = Colors.white;
        borderColor = Colors.red.shade600;
        icon = Icons.cancel;
      }
    } else if (widget.isAnswered && isCorrectOption) {
      backgroundColor = Colors.green.shade500;
      textColor = Colors.white;
      borderColor = Colors.green.shade600;
      icon = Icons.check_circle;
    } else {
      backgroundColor = Colors.white;
      textColor = const Color(0xFF1F2233);
      borderColor = Colors.grey.shade200;
    }

    // Correct answer gently pulses; wrong pick scales down slightly.
    double scale = 1.0;
    if (_pressed && !widget.isAnswered) scale = 0.97;
    if (widget.isAnswered && isCorrectOption) scale = 1.03;

    final Widget card = AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: widget.isAnswered
              ? [
                  BoxShadow(
                    color: (isCorrectOption
                            ? Colors.green
                            : isSelected
                                ? Colors.red
                                : Colors.grey)
                        .withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: widget.isAnswered ? null : widget.onTap,
            onTapDown: widget.isAnswered
                ? null
                : (_) => setState(() => _pressed = true),
            onTapUp: widget.isAnswered
                ? null
                : (_) => setState(() => _pressed = false),
            onTapCancel: () => setState(() => _pressed = false),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor, width: 2),
              ),
              child: Row(
                children: [
                  // Option letter badge
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: widget.isAnswered
                          ? textColor.withOpacity(0.2)
                          : primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        optionLetters[widget.index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: widget.isAnswered ? textColor : primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Option text
                  Expanded(
                    child: Text(
                      widget.option,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                        height: 1.4,
                      ),
                    ),
                  ),
                  // Icon indicator
                  if (icon != null && widget.isAnswered)
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Icon(icon, color: textColor, size: 24),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // Apply a horizontal shake when the user picks the wrong answer.
    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        final dx = sin(_shakeController.value * pi * 4) *
            12 *
            (1 - _shakeController.value);
        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
      child: card,
    );
  }
}

/// Sample quiz data for testing
///
/// This is embedded in the code for easy testing.
/// In production, you would load this from a JSON file or asset bundle.
final List<Map<String, dynamic>> sampleQuizData = [
  {
    "que": "What does HTML stand for?",
    "options": [
      "HyperText Markup Language",
      "HighText Machine Language",
      "Hyper Transfer Markup Language",
      "Home Tool Markup Language"
    ],
    "ans": 0
  },
  {
    "que": "Which language is commonly used to add interactivity to web pages?",
    "options": ["HTML", "CSS", "JavaScript", "SQL"],
    "ans": 2
  },
  {
    "que": "Which HTML tag is commonly used for the largest page heading?",
    "options": ["<heading>", "<h1>", "<head>", "<title>"],
    "ans": 1
  },
  {
    "que": "Which JavaScript keyword is used to declare a block-scoped variable?",
    "options": ["var", "let", "define", "constvar"],
    "ans": 1
  },
  {
    "que": "Which method is commonly used to select an element by ID in JavaScript?",
    "options": [
      "queryElement()",
      "getElementByName()",
      "getElementById()",
      "selectById()"
    ],
    "ans": 2
  },
  {
    "que": "What is Hot Reload in Flutter?",
    "options": [
      "A debugging tool",
      "A way to update UI without restarting",
      "A build system",
      "A testing framework"
    ],
    "ans": 1
  },
  {
    "que": "What is the purpose of setState()?",
    "options": [
      "To navigate between screens",
      "To update the UI when state changes",
      "To make API calls",
      "To store data"
    ],
    "ans": 1
  },
  {
    "que": "Which widget is used for scrolling lists?",
    "options": ["Column", "Row", "ListView", "Container"],
    "ans": 2
  },
  {
    "que": "What is a StatelessWidget?",
    "options": [
      "A widget that can change",
      "A widget that cannot change",
      "A widget with state",
      "A widget for animations"
    ],
    "ans": 1
  },
  {
    "que": "What is a StatefulWidget?",
    "options": [
      "A widget that cannot change",
      "A widget that can change over time",
      "A widget without state",
      "A widget for static content"
    ],
    "ans": 1
  },
  {
    "que": "What is the MaterialApp widget used for?",
    "options": [
      "To create a single screen",
      "To create the app structure",
      "To handle navigation only",
      "To manage state"
    ],
    "ans": 1
  },
  {
    "que": "What is the Scaffold widget used for?",
    "options": [
      "To create the app structure",
      "To create a basic page layout",
      "To handle navigation",
      "To manage state"
    ],
    "ans": 1
  },
  {
    "que": "What is the purpose of Navigator?",
    "options": [
      "To manage state",
      "To navigate between screens",
      "To handle user input",
      "To make API calls"
    ],
    "ans": 1
  },
  {
    "que": "What is the BuildContext used for?",
    "options": [
      "To store data",
      "To locate widgets in the tree",
      "To handle animations",
      "To make network requests"
    ],
    "ans": 1
  },
  {
    "que": "What is the purpose of async/await in Flutter?",
    "options": [
      "To handle synchronous operations",
      "To handle asynchronous operations",
      "To manage state",
      "To create animations"
    ],
    "ans": 1
  },
  {
    "que": "What is the Future widget used for?",
    "options": [
      "To handle synchronous operations",
      "To handle asynchronous operations",
      "To manage state",
      "To create layouts"
    ],
    "ans": 1
  },
  {
    "que": "What is the purpose of pubspec.yaml?",
    "options": [
      "To define app configuration",
      "To manage dependencies",
      "To handle navigation",
      "To manage state"
    ],
    "ans": 1
  },
  {
    "que": "What is the purpose of the const keyword?",
    "options": [
      "To make widgets mutable",
      "To create compile-time constants",
      "To handle state",
      "To create animations"
    ],
    "ans": 1
  },
  {
    "que": "What is the purpose of the key parameter?",
    "options": [
      "To identify widgets uniquely",
      "To handle navigation",
      "To manage state",
      "To create animations"
    ],
    "ans": 0
  },
  {
    "que": "What is the purpose of the Theme widget?",
    "options": [
      "To handle navigation",
      "To define app-wide styling",
      "To manage state",
      "To create animations"
    ],
    "ans": 1
  },
];
