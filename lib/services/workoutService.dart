import 'package:fitnet/models/workout.dart';
import 'package:fitnet/services/firestoreService.dart';

import '../serviceInjector.dart';

class WorkoutService {
  final FirestoreService firestore = injector<FirestoreService>();

  Stream<List<Workout>> getWorkoutStreamForUser(String uid) {
    return firestore.getWorkoutStreamForUser(uid);
  }
}
