import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';

import '../serviceInjector.dart';

class FirebaseStorageService {
  final FirebaseStorage storage = injector<FirebaseStorage>();

  Future<String> getImageDownloadUrl(String filename) async {
    return await storage.ref().child(filename).getDownloadURL();
  }
}
