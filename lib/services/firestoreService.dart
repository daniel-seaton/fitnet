import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnet/models/appUser.dart';

import '../serviceInjector.dart';

class FirestoreService {
  final FirebaseFirestore firestore = injector<FirebaseFirestore>();

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

  Future<AppUser> getUser(String uid) async {
    CollectionReference appUsersRef = firestore.collection('appUsers');
    List<QueryDocumentSnapshot> userSnapshots = await appUsersRef
        .where('uid', isEqualTo: uid)
        .get()
        .then((QuerySnapshot query) {
      return query.docs;
    });
    if (userSnapshots.length > 1) {
      print('Too many users exist for credentials');
      throw Error();
    } else if (userSnapshots.length == 0) {
      print('No user exists for uid $uid');
      return null;
    } else {
      return AppUser.fromMap(userSnapshots[0].data());
    }
  }
}
