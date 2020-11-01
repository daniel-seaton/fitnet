import 'package:fitnet/models/workout.dart';
import 'package:fitnet/services/firestoreService.dart';

import '../serviceInjector.dart';

class WorkoutService {
  final FirestoreService firestore = injector<FirestoreService>();

  Stream<List<Workout>> getWorkoutStreamForUser(String uid) {
    return firestore.getWorkoutStreamForUser(uid);
  }

  addOrUpdateWorkout(Workout workout) async {
    print(workout.wid);
    if (workout.wid == null)
      await firestore.addWorkout(workout);
    else
      await firestore.updateWorkout(workout);
  }
}
