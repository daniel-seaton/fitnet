import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnet/models/workout.dart';

import '../serviceInjector.dart';

class WorkoutService {
  final FirebaseFirestore firestore = injector<FirebaseFirestore>();
  final String workoutCollection = 'workouts';

  Stream<List<Workout>> getWorkoutStreamForUser(String uid) {
    CollectionReference workoutRef = firestore.collection(workoutCollection);
    return workoutRef
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

  addOrUpdateWorkout(Workout workout) async {
    CollectionReference workoutRef = firestore.collection(workoutCollection);
    if (workout.wid == null)
      await workoutRef.add(workout.toMap());
    else
      await workoutRef.doc(workout.wid).update(workout.toMap());
  }

  addNewInstance(Workout workout) async {
    CollectionReference workoutRef = firestore.collection(workoutCollection);
    if (workout.linkId == null) {
      workout.linkId = workout.wid;
      await workoutRef.doc(workout.wid).update(workout.toMap());
    }
    workout.wid = null;
    workout.scheduled = DateTime.now();
    workout.start = null;
    workout.end = null;
    await workoutRef.add(workout.toMap());
  }

  deleteWorkout(Workout workout) async {
    CollectionReference workoutRef = firestore.collection(workoutCollection);
    workoutRef.doc(workout.wid).delete();
  }
}
