import 'package:flutter/material.dart';
import '../../data/models/question_model.dart';
import '../../data/repositories/quiz_repository.dart';

class QuizProvider with ChangeNotifier {
  final QuizRepository _repository = QuizRepository();

  List<QuestionModel> questions = [];
  int currentIndex = 0;
  int score = 0;
  bool isLoading = false;

  Future<void> loadQuestions() async {
    isLoading = true;
    notifyListeners();

    questions = await _repository.fetchCultureQuestions();

    isLoading = false;
    notifyListeners();
  }

  void answer(int selectedIndex) {
    if (selectedIndex == questions[currentIndex].correctIndex) {
      score++;
    }
    currentIndex++;
    notifyListeners();
  }

  void reset() {
    currentIndex = 0;
    score = 0;
    questions = [];
    isLoading = false;
    notifyListeners();
  }

  bool get isFinished => currentIndex >= questions.length;
}
