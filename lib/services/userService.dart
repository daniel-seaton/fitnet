import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitnet/models/appUser.dart';

import '../serviceinjector.dart';

class UserService {
  final FirebaseFirestore firestore = injector<FirebaseFirestore>();
  final FirebaseStorage storage = injector<FirebaseStorage>();
  final String userCollection = 'appUsers';

  Future<AppUser> getUser(String uid) async {
    CollectionReference appUsersRef = firestore.collection(userCollection);
    List<QueryDocumentSnapshot> userSnapshots = await appUsersRef
        .where('uid', isEqualTo: uid)
        .get()
        .then((QuerySnapshot query) {
      return query.docs;
    });
    if (userSnapshots.length > 1) {
      print('Too many users exist for credentials');
      throw Exception();
    } else if (userSnapshots.length == 0) {
      print('No user exists for uid $uid');
      return null;
    } else {
      return AppUser.fromMap(userSnapshots[0].data());
    }
  }

  Future<AppUser> createNew(String uid, String firstName, String lastName,
      [String city, String state, int weight, int height]) async {
    AppUser user =
        AppUser(uid, firstName, lastName, city, state, weight, height);
    CollectionReference appUsersRef = firestore.collection(userCollection);
    try {
      await appUsersRef.add(user.toMap());
      return user;
    } catch (e) {
      print('Unable to add user $user: $e');
      return null;
    }
  }

  Stream<AppUser> getUserStream(String uid) {
    CollectionReference appUsersRef = firestore.collection(userCollection);
    return appUsersRef
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot query) => AppUser.fromMap(query.docs[0].data()));
  }

  Future<String> getImageDownloadUrl(String filename) async {
    return await storage.ref().child(filename).getDownloadURL();
  }

  Future<void> uploadImageForUser(AppUser user, File image) async {
    StorageUploadTask uploadTask = storage.ref().child(user.uid).putFile(image);
    await uploadTask.onComplete;

    CollectionReference appUsersRef = firestore.collection(userCollection);
    List<QueryDocumentSnapshot> userSnapshots = await appUsersRef
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((QuerySnapshot query) {
      return query.docs;
    });
    if (userSnapshots.length > 1) {
      print('Too many users exist for credentials');
      throw Exception();
    } else if (userSnapshots.length == 0) {
      print('No user exists for uid ${user.uid}');
      return null;
    }
    return appUsersRef
        .doc(userSnapshots[0].id)
        .update({'profileImageVersion': user.profileImageVersion + 1});
  }
}
