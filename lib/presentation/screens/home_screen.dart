import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quizz_firebase/business_logic/providers/quiz_provider.dart';
import 'package:quizz_firebase/data/repositories/storage_repository.dart';

import '../../business_logic/providers/auth_provider.dart';
import '../theme/app_colors.dart';
import 'quiz_screen.dart';
import 'add_question_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final quizProvider =
    Provider.of<QuizProvider>(context, listen: false);


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: const Text('Quiz Culture 🎓'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Déconnexion',
            onPressed: () => auth.logout(),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),

              // 👤 AVATAR
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 44,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        auth.user?.email?.substring(0, 1).toUpperCase() ?? 'U',
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // ➕ Bouton ajouter photo
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final picked = await picker.pickImage(
                          source: ImageSource.gallery,
                        );

                        if (picked != null) {
                          final file = File(picked.path);
                          final storage = StorageRepository();

                          final url = await storage.uploadAvatar(
                            file,
                            auth.user!.uid,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Avatar uploadé ✅')),
                          );

                          // 🔜 OPTIONNEL PLUS TARD :
                          // sauvegarder l’URL dans Firestore
                        }
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: AppColors.secondary,
                        child: const Icon(
                          Icons.add,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Email
              Text(
                auth.user?.email ?? '',
                style: const TextStyle(color: Color.fromARGB(233, 255, 255, 255), fontSize: 20),
              ),

              const SizedBox(height: 40),

              // 🎓 Welcome Card
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.school,
                        size: 60,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Bienvenue 👋',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),

                      const SizedBox(height: 20),

                      // ▶️ Start Quiz
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.play_arrow),
                          label: const Text(
                            'Commencer le Quiz Culture',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            quizProvider.reset();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const QuizScreen(),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 14),

                      // ➕ Add Question
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text(
                            'Ajouter une question',
                            style: TextStyle(color: AppColors.primary),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AddQuestionScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // 💡 Footer text
              const Text(
                'Apprends en t’amusant 📚✨',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
