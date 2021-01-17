import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutInstance.dart';

import '../serviceInjector.dart';

class WorkoutInstanceService {
  FirebaseFirestore firestore = injector<FirebaseFirestore>();
  final String workoutInstanceCollection = 'workoutInstances';

  Future<WorkoutInstance> addNewInstance(Workout workout) async {
    CollectionReference instanceRef =
        firestore.collection(workoutInstanceCollection);
    WorkoutInstance instance = WorkoutInstance.fromWorkout(workout);
    instance.start = DateTime.now();
    DocumentReference doc = await instanceRef.add(instance.toMap());
    instance.iid = doc.id;
    return instance;
  }

  Future<void> updateInstance(WorkoutInstance instance) async {
    CollectionReference instanceRef =
        firestore.collection(workoutInstanceCollection);
    await instanceRef.doc(instance.iid).update(instance.toMap());
  }

  Future<List<WorkoutInstance>> getInstancesByWid(String wid) async {
    CollectionReference instanceRef =
        firestore.collection(workoutInstanceCollection);
    QuerySnapshot query = await instanceRef.where('wid', isEqualTo: wid).get();
    List<WorkoutInstance> workouts = [];
    query.docs.forEach((doc) =>
        workouts.add(WorkoutInstance.fromMap({...doc.data(), 'iid': doc.id})));
    workouts.sort((a, b) => a.start.isBefore(b.start) ? 1 : -1);
    return workouts;
  }

  Stream<List<WorkoutInstance>> getInstancesStreamByWid(String wid) {
    CollectionReference instanceRef =
        firestore.collection(workoutInstanceCollection);
    return instanceRef
        .where('wid', isEqualTo: wid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<WorkoutInstance> workouts = [];
      query.docs.forEach((doc) => workouts
          .add(WorkoutInstance.fromMap({...doc.data(), 'iid': doc.id})));
      workouts.sort((a, b) => a.start.isBefore(b.start) ? 1 : -1);
      return workouts;
    });
  }

  Future<void> deleteInstancesByWid(String wid) async {
    CollectionReference instanceRef =
        firestore.collection(workoutInstanceCollection);
    await instanceRef.where('wid', isEqualTo: wid).get().then((snapshot) {
      var batch = firestore.batch();
      snapshot.docs.forEach((doc) {
        // For each doc, add a delete operation to the batch
        batch.delete(doc.reference);
      });
      // Commit the batch
      return batch.commit();
    });
  }
}
