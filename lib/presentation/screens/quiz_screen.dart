import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business_logic/providers/quiz_provider.dart';
import '../theme/app_colors.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<QuizProvider>(context);

    if (quiz.questions.isEmpty && !quiz.isLoading) {
      quiz.loadQuestions();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text('Quiz Culture 🧠'),
      ),
      body: quiz.isLoading
          ? const Center(child: CircularProgressIndicator())
          : quiz.isFinished
              ? _buildResult(context, quiz)
              : _buildQuestion(context, quiz),
    );
  }

  // ================= QUESTION =================

  Widget _buildQuestion(BuildContext context, QuizProvider quiz) {
    final question = quiz.questions[quiz.currentIndex];
    final progress =
        (quiz.currentIndex + 1) / quiz.questions.length;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Progress
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade300,
            valueColor:
                const AlwaysStoppedAnimation(AppColors.primary),
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 24),

          // Question card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    'Question ${quiz.currentIndex + 1}',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    question.question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Answers
          ...List.generate(question.answers.length, (i) {
            final isSelected = selectedIndex == i;
            final isCorrect = i == question.correctIndex;

            Color buttonColor = AppColors.primary;
            if (selectedIndex != null) {
              if (isCorrect) {
                buttonColor = Colors.green;
              } else if (isSelected && !isCorrect) {
                buttonColor = Colors.red;
              }
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: selectedIndex == null
                      ? () {
                          setState(() {
                            selectedIndex = i;
                          });

                          Future.delayed(
                            const Duration(milliseconds: 700),
                            () {
                              quiz.answer(i);
                              setState(() {
                                selectedIndex = null;
                              });
                            },
                          );
                        }
                      : null,
                  child: Text(
                    question.answers[i],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ================= RESULT =================

  Widget _buildResult(BuildContext context, QuizProvider quiz) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.emoji_events,
                size: 80,
                color: AppColors.primary,
              ),
              const SizedBox(height: 20),
              const Text(
                'Quiz terminé 🎉',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Score : ${quiz.score} / ${quiz.questions.length}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Retour à l’accueil'),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
