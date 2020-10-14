import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnet/models/AppUser.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirestoreService();

  Future<AppUser> addUser(AppUser user) async {
    CollectionReference appUsersRef = firestore.collection('appUsers');
    try {
      await appUsersRef.add(user.toMap());
      return user;
    } catch (e) {
      print('Unable to add user $user: $e');
      return null;
    }
  }

  Future<AppUser> getUserByCredential(UserCredential userCredentials) async {
    CollectionReference appUsersRef = firestore.collection('appUsers');
    List<QueryDocumentSnapshot> userSnapshots = await appUsersRef
        .where('credentials', isEqualTo: userCredentials)
        .get()
        .then((QuerySnapshot query) {
      return query.docs;
    });
    if (userSnapshots.length > 1) {
      print('Too many users exist for credentials');
      throw Error();
    } else if (userSnapshots.length == 0) {
      print('No user exists for credentials $userCredentials');
      return null;
    } else {
      return AppUser.fromMap(userSnapshots[0].data());
    }
  }
}
