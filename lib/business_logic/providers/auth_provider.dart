import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _repo = AuthRepository();
  User? user;

  AuthProvider() {
    user = _repo.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((u) {
      user = u;
      notifyListeners();
    });
  }

  Future<void> login(String email, String password) async {
    user = await _repo.login(email, password);
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    user = await _repo.register(email, password);
    notifyListeners();
  }

  void logout() {
    _repo.logout();
    user = null;
    notifyListeners();
  }

  bool get isLoggedIn => user != null;
}
