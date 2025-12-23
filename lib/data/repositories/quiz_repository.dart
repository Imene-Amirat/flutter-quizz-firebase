import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/question_model.dart';

class QuizRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<QuestionModel>> fetchCultureQuestions() async {
    final snapshot = await _db
        .collection('questions')
        .where('theme', isEqualTo: 'Culture')
        .get();

    return snapshot.docs
        .map((doc) =>
            QuestionModel.fromFirestore(doc.id, doc.data()))
        .toList();
  }
}
