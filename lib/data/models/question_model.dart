class QuestionModel {
  final String id;
  final String theme;
  final String question;
  final List<String> answers;
  final int correctIndex;

  QuestionModel({
    required this.id,
    required this.theme,
    required this.question,
    required this.answers,
    required this.correctIndex,
  });

  factory QuestionModel.fromFirestore(
      String id, Map<String, dynamic> data) {
    return QuestionModel(
      id: id,
      theme: data['theme'],
      question: data['question'],
      answers: List<String>.from(data['answers']),
      correctIndex: data['correctIndex'],
    );
  }
}
