import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/services/workoutInstanceService.dart';

import '../serviceInjector.dart';

class WorkoutService {
  final FirebaseFirestore firestore = injector<FirebaseFirestore>();
  final WorkoutInstanceService instanceService =
      injector<WorkoutInstanceService>();
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
      workouts.sort((x, y) => x.updated.isBefore(y.updated) ? 1 : -1);
      return workouts;
    });
  }

  Future<void> addOrUpdateWorkout(Workout workout) async {
    CollectionReference workoutRef = firestore.collection(workoutCollection);
    if (workout.wid == null)
      await workoutRef.add(workout.toMap());
    else {
      workout.updated = DateTime.now();
      await workoutRef.doc(workout.wid).update(workout.toMap());
    }
  }

  deleteWorkout(Workout workout) async {
    CollectionReference workoutRef = firestore.collection(workoutCollection);
    workoutRef.doc(workout.wid).delete();
    instanceService.deleteInstancesByWid(workout.wid);
  }
}
