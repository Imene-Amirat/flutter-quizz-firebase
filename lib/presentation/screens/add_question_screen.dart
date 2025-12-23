import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../theme/app_colors.dart';

class AddQuestionScreen extends StatefulWidget {
  const AddQuestionScreen({super.key});

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final themeCtrl = TextEditingController();
  final questionCtrl = TextEditingController();
  final a1Ctrl = TextEditingController();
  final a2Ctrl = TextEditingController();
  final a3Ctrl = TextEditingController();
  final a4Ctrl = TextEditingController();
  final correctCtrl = TextEditingController();

  Future<void> addQuestion() async {
    await FirebaseFirestore.instance.collection('questions').add({
      'theme': themeCtrl.text,
      'question': questionCtrl.text,
      'answers': [
        a1Ctrl.text,
        a2Ctrl.text,
        a3Ctrl.text,
        a4Ctrl.text,
      ],
      'correctIndex': int.parse(correctCtrl.text),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Ajouter une question'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.secondary,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Center(
                    child: Column(
                      children: const [
                        Icon(
                          Icons.edit_note,
                          size: 48,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Nouvelle question',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),

                  _field(
                    controller: themeCtrl,
                    label: 'Thème (ex: Culture)',
                    icon: Icons.category,
                  ),

                  _field(
                    controller: questionCtrl,
                    label: 'Question',
                    icon: Icons.help_outline,
                    maxLines: 2,
                  ),

                  const SizedBox(height: 12),
                  const Text(
                    'Réponses',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _field(
                    controller: a1Ctrl,
                    label: 'Réponse 1',
                    icon: Icons.looks_one,
                  ),
                  _field(
                    controller: a2Ctrl,
                    label: 'Réponse 2',
                    icon: Icons.looks_two,
                  ),
                  _field(
                    controller: a3Ctrl,
                    label: 'Réponse 3',
                    icon: Icons.looks_3,
                  ),
                  _field(
                    controller: a4Ctrl,
                    label: 'Réponse 4',
                    icon: Icons.looks_4,
                  ),

                  _field(
                    controller: correctCtrl,
                    label: 'Index de la bonne réponse (0-3)',
                    icon: Icons.check_circle_outline,
                    keyboard: TextInputType.number,
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: const Text(
                        'Enregistrer la question',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: addQuestion,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ------------------ FIELD ------------------

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
