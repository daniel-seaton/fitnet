import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnet/models/workout.dart';

import '../serviceInjector.dart';

class WorkoutService {
  final FirebaseFirestore firestore = injector<FirebaseFirestore>();
  final String workoutCollection = 'workouts';

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

  addOrUpdateWorkout(Workout workout) async {
    CollectionReference workoutRep = firestore.collection(workoutCollection);
    if (workout.wid == null)
      await workoutRep.add(workout.toMap());
    else
      await workoutRep.doc(workout.wid).update(workout.toMap());
  }
}
