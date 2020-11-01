import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/models/workout.dart';

import '../serviceInjector.dart';

class FirestoreService {
  final FirebaseFirestore firestore = injector<FirebaseFirestore>();
  final String userCollection = 'appUsers';
  final String workoutCollection = 'workouts';

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

  Stream<List<Workout>> getWorkoutStreamForUser(String uid) {
    CollectionReference workoutRep = firestore.collection(workoutCollection);
    return workoutRep
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Workout> workouts = [];
      query.docs.forEach((doc) =>
          workouts.add(Workout.fromMap({...doc.data(), 'wid': doc.id})));
      workouts.sort((x, y) => x.scheduled.isBefore(y.scheduled) ? 1 : -1);
      return workouts;
    });
  }

  Future<void> addWorkout(Workout workout) async {
    CollectionReference workoutRep = firestore.collection(workoutCollection);
    return await workoutRep.add(workout.toMap());
  }

  Future<void> updateWorkout(Workout workout) async {
    CollectionReference workoutRep = firestore.collection(workoutCollection);
    return await workoutRep.doc(workout.wid).update(workout.toMap());
  }
}
