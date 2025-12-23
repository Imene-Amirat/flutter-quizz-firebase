import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadAvatar(File file, String uid) async {
    final ref = _storage.ref().child('avatars/$uid.jpg');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<String> uploadSound(File file, String name) async {
    final ref = _storage.ref().child('sounds/$name');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
