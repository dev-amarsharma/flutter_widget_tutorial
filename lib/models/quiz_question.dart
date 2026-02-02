/// Model class representing a quiz question
/// 
/// Each question contains:
/// - que: The question text
/// - options: List of 4 answer options (A, B, C, D)
/// - ans: The index of the correct answer (0-based)
class QuizQuestion {
  final String que;
  final List<String> options;
  final int ans; // 0-based index of correct answer

  QuizQuestion({
    required this.que,
    required this.options,
    required this.ans,
  });

  /// Parse a QuizQuestion from JSON
  /// Supports both integer indices (0, 1, 2, 3) and letter answers ("a", "b", "c", "d")
  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    final ansValue = json['ans'];
    int ansIndex;
    
    // Handle both integer and string (letter) formats
    if (ansValue is int) {
      ansIndex = ansValue;
    } else if (ansValue is String) {
      // Convert letter to index: "a" -> 0, "b" -> 1, "c" -> 2, "d" -> 3
      final letter = ansValue.toLowerCase();
      ansIndex = letter.codeUnitAt(0) - 'a'.codeUnitAt(0);
    } else {
      throw FormatException('Invalid answer format: $ansValue');
    }
    
    return QuizQuestion(
      que: json['que'] as String,
      options: List<String>.from(json['options'] as List),
      ans: ansIndex,
    );
  }

  /// Parse a list of QuizQuestions from JSON array
  static List<QuizQuestion> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => QuizQuestion.fromJson(json as Map<String, dynamic>)).toList();
  }

  /// Convert to JSON (useful for testing or storage)
  Map<String, dynamic> toJson() {
    return {
      'que': que,
      'options': options,
      'ans': ans,
    };
  }
}
