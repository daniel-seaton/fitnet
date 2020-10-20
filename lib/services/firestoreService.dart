import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnet/models/appUser.dart';

import '../serviceInjector.dart';

class FirestoreService {
  final FirebaseFirestore firestore = injector<FirebaseFirestore>();
  final String userCollection = 'appUsers';

  Future<AppUser> addUser(AppUser user) async {
    CollectionReference appUsersRef = firestore.collection(userCollection);
    try {
      await appUsersRef.add(user.toMap());
      return user;
    } catch (e) {
      print('Unable to add user $user: $e');
      return null;
    }
  }

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

  Stream<AppUser> getUserStream(String uid) {
    CollectionReference appUsersRef = firestore.collection(userCollection);
    return appUsersRef
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot query) => AppUser.fromMap(query.docs[0].data()));
  }

  Future<void> updateProfileImageVersion(AppUser user) async {
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
