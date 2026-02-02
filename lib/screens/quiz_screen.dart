import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/quiz_question.dart';
import '../services/rewarded_ad_service.dart';
import '../services/interstitial_ad_service.dart';
import '../widgets/banner_ad_widget.dart';

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

  const QuizScreen({
    super.key,
    required this.questions,
    this.timerDurationSeconds = 30,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Quiz state
  late List<QuizQuestion> _selectedQuestions;
  int _currentQuestionIndex = 0;
  int _lives = 3;
  int _score = 0;
  int _correctCount = 0;
  int _wrongCount = 0;
  
  // Timer state
  Timer? _timer;
  int _timeRemaining = 30;
  bool _isAnswered = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _initializeQuiz();
  }

  /// Initialize quiz: randomize and select questions (up to available count)
  void _initializeQuiz() {
    final random = Random();
    final shuffled = List<QuizQuestion>.from(widget.questions)..shuffle(random);
    // Select up to the number of questions available, but prefer 40 if available
    final questionCount = widget.questions.length >= 40 ? 40 : widget.questions.length;
    _selectedQuestions = shuffled.take(questionCount).toList();
    _timeRemaining = widget.timerDurationSeconds;
    _startTimer();
  }

  /// Start the countdown timer for current question
  void _startTimer() {
    _timeRemaining = widget.timerDurationSeconds;
    _isAnswered = false;
    
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
  void _handleTimeout() {
    if (_isAnswered) return;
    
    _timer?.cancel();
    _isAnswered = true;
    _wrongCount++;
    _lives--;
    
    if (_lives <= 0) {
      _showLivesLostDialog();
    } else {
      _moveToNextQuestion();
    }
  }

  /// Handle answer selection
  void _handleAnswer(int selectedIndex) {
    if (_isAnswered) return; // Prevent double-taps
    
    _timer?.cancel();
    _isAnswered = true;
    
    final question = _selectedQuestions[_currentQuestionIndex];
    final isCorrect = selectedIndex == question.ans;
    
    setState(() {
      if (isCorrect) {
        _correctCount++;
        _score += 10; // +10 points per correct answer
      } else {
        _wrongCount++;
        _lives--;
      }
    });
    
    // Show visual feedback briefly before moving on
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      
      if (_lives <= 0) {
        _showLivesLostDialog();
      } else if (_currentQuestionIndex < _selectedQuestions.length - 1) {
        _moveToNextQuestion();
      } else {
        _showResultScreen();
      }
    });
  }

  /// Move to next question
  void _moveToNextQuestion() {
    if (_currentQuestionIndex < _selectedQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      _startTimer();
    } else {
      _showResultScreen();
    }
  }

  /// Show dialog when all lives are lost
  void _showLivesLostDialog() {
    _isPaused = true;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red.shade400,
                Colors.orange.shade400,
              ],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.sentiment_dissatisfied,
                  size: 64,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              // Title
              const Text(
                'Better Luck Next Time!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              // Message
              const Text(
                'You\'ve run out of lives!\nWatch a reward video to continue.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _exitQuiz();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white, width: 2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Exit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _watchRewardVideo();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red.shade600,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.play_circle_outline, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Watch Ad',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
              content: Text('Content loading failed. Please try after some time.'),
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
            content: Text('Content loading failed. Please try after some time.'),
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
        if (_currentQuestionIndex < _selectedQuestions.length - 1) {
          _moveToNextQuestion();
        } else {
          _showResultScreen();
        }
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
            content: Text('Content loading failed. Please try after some time.'),
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
  /// Shows interstitial ad before exiting (following AdMob policies)
  Future<void> _exitQuiz() async {
    _timer?.cancel();
    
    // Show interstitial ad before exiting
    await interstitialAdService.showInterstitialAd();
    
    // Small delay to ensure ad is shown
    await Future.delayed(const Duration(milliseconds: 500));
    
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
  void _showResultScreen() {
    _timer?.cancel();
    _isPaused = true;
    
    final result = QuizResult(
      totalQuestions: _selectedQuestions.length,
      correctAnswers: _correctCount,
      wrongAnswers: _wrongCount,
      remainingLives: _lives,
      score: _score,
    );
    
    final percentage = (result.correctAnswers / result.totalQuestions * 100).round();
    final isExcellent = percentage >= 80;
    final isGood = percentage >= 60;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isExcellent
                  ? [Colors.green.shade400, Colors.teal.shade400]
                  : isGood
                      ? [Colors.blue.shade400, Colors.purple.shade400]
                      : [Colors.orange.shade400, Colors.pink.shade400],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Trophy/Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isExcellent
                        ? Icons.emoji_events
                        : isGood
                            ? Icons.star
                            : Icons.thumb_up,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                // Title
                Text(
                  isExcellent
                      ? 'Excellent!'
                      : isGood
                          ? 'Good Job!'
                          : 'Quiz Complete!',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                // Score
                Text(
                  'Score: ${result.score}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                // Results card
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
                const SizedBox(height: 24),
                // Done button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(result);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: isExcellent
                          ? Colors.green.shade600
                          : isGood
                              ? Colors.blue.shade600
                              : Colors.orange.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedQuestions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: const Center(
          child: Text('No questions available'),
        ),
      );
    }

    final question = _selectedQuestions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _selectedQuestions.length;

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
          builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Warning icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.warning_amber_rounded,
                      size: 48,
                      color: Colors.orange.shade600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Title
                  const Text(
                    'Exit Quiz?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Message
                  const Text(
                    'Your progress will be lost.\nAre you sure you want to exit?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey.shade300),
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Exit',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
        
        if (shouldExit == true && mounted) {
          _timer?.cancel();
          // Show interstitial ad before exiting (following AdMob policies)
          await interstitialAdService.showInterstitialAd();
          await Future.delayed(const Duration(milliseconds: 500));
          if (mounted) {
            navigator.pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
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
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.8),
                ],
              ),
            ),
          ),
          actions: [
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Icon(
                      index < _lives ? Icons.favorite : Icons.favorite_border,
                      color: index < _lives ? Colors.red.shade300 : Colors.white70,
                      size: 22,
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
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            : Column(
                children: [
                  // Progress bar with gradient
                  Container(
                    height: 6,
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  
                  // Timer section with card
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: _timeRemaining <= 5
                            ? [Colors.red.shade400, Colors.orange.shade400]
                            : [Colors.blue.shade400, Colors.purple.shade400],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: (_timeRemaining <= 5 ? Colors.red : Colors.blue)
                              .withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Time Remaining',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Timer text
                        Text(
                          '$_timeRemaining',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Timer progress bar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: _timeRemaining / widget.timerDurationSeconds,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Question section
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Question card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
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
                            child: Text(
                              question.que,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                height: 1.4,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Answer options
                          ...List.generate(question.options.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: _AnswerButton(
                                option: question.options[index],
                                index: index,
                                correctIndex: question.ans,
                                isAnswered: _isAnswered,
                                onTap: () => _handleAnswer(index),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  
                  // Banner ad at the bottom (following AdMob policies)
                  const BannerAdWidget(),
                ],
              ),
      ),
    );
  }
}

/// Answer option button widget
/// Shows visual feedback (green for correct, red for wrong)
class _AnswerButton extends StatefulWidget {
  final String option;
  final int index;
  final int correctIndex;
  final bool isAnswered;
  final VoidCallback onTap;

  const _AnswerButton({
    required this.option,
    required this.index,
    required this.correctIndex,
    required this.isAnswered,
    required this.onTap,
  });

  @override
  State<_AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<_AnswerButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final optionLetters = ['A', 'B', 'C', 'D'];
    late Color backgroundColor;
    late Color textColor;
    late Color borderColor;
    IconData? icon;
    
    if (widget.isAnswered && _isSelected) {
      // User selected this option
      if (widget.index == widget.correctIndex) {
        backgroundColor = Colors.green.shade500;
        textColor = Colors.white;
        borderColor = Colors.green.shade700;
        icon = Icons.check_circle;
      } else {
        backgroundColor = Colors.red.shade500;
        textColor = Colors.white;
        borderColor = Colors.red.shade700;
        icon = Icons.cancel;
      }
    } else if (widget.isAnswered && widget.index == widget.correctIndex) {
      // Show correct answer in green
      backgroundColor = Colors.green.shade500;
      textColor = Colors.white;
      borderColor = Colors.green.shade700;
      icon = Icons.check_circle;
    } else {
      // Default state
      backgroundColor = Colors.white;
      textColor = Colors.black87;
      borderColor = Colors.grey.shade300;
    }
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: widget.isAnswered
            ? [
                BoxShadow(
                  color: (widget.index == widget.correctIndex
                          ? Colors.green
                          : _isSelected
                              ? Colors.red
                              : Colors.grey)
                      .withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: widget.isAnswered ? null : () {
            setState(() => _isSelected = true);
            widget.onTap();
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: borderColor,
                width: 2,
              ),
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
                        : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      optionLetters[widget.index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: widget.isAnswered
                            ? textColor
                            : Theme.of(context).colorScheme.primary,
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
                    child: Icon(
                      icon,
                      color: textColor,
                      size: 24,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Sample quiz data for testing
/// 
/// This is embedded in the code for easy testing.
/// In production, you would load this from a JSON file or API.
final List<Map<String, dynamic>> sampleQuizData = [
  {
    "que": "What is Flutter?",
    "options": [
      "A mobile app development framework",
      "A database management system",
      "A web server framework",
      "A programming language"
    ],
    "ans": 0
  },
  {
    "que": "Which programming language does Flutter use?",
    "options": [
      "Java",
      "Dart",
      "Kotlin",
      "Swift"
    ],
    "ans": 1
  },
  {
    "que": "What is a Widget in Flutter?",
    "options": [
      "A UI component",
      "A database table",
      "A network request",
      "A file system"
    ],
    "ans": 0
  },
  {
    "que": "What is the main function used for in Flutter?",
    "options": [
      "To define routes",
      "To initialize the app",
      "To handle user input",
      "To manage state"
    ],
    "ans": 1
  },
  {
    "que": "Which widget is used for layout in Flutter?",
    "options": [
      "Container",
      "Row and Column",
      "Text",
      "Button"
    ],
    "ans": 1
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
    "options": [
      "Column",
      "Row",
      "ListView",
      "Container"
    ],
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
