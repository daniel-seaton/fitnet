import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/firestoreService.dart';

import '../serviceinjector.dart';
import 'firebaseStorageService.dart';

class UserService {
  final FirestoreService firestoreService = injector<FirestoreService>();
  final FirebaseStorageService storageService =
      injector<FirebaseStorageService>();

  Future<AppUser> getUser(String uid) async {
    return await firestoreService.getUser(uid);
  }

  Future<AppUser> createNew(String uid, String firstName, String lastName,
      [String city, String state, int weight, int height]) async {
    AppUser user =
        AppUser(uid, firstName, lastName, city, state, weight, height);
    return await firestoreService.addUser(user);
  }

  Stream<AppUser> getUserStream(String uid) {
    return firestoreService.getUserStream(uid);
  }

  Future<String> getImageDownloadUrl(String filename) async {
    return await storageService.getImageDownloadUrl(filename);
  }

  Future<void> uploadImageForUser(AppUser user, File image) async {
    StorageUploadTask uploadTask =
        await storageService.uploadFile(user.uid, image);
    await uploadTask.onComplete;
    await firestoreService.updateProfileImageVersion(user);
  }
}
