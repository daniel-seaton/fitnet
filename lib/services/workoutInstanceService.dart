import 'dart:convert';

import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/services/baseService.dart';
import 'package:fitnet/utils/debouncer.dart';
import 'package:http/http.dart';

class WorkoutInstanceService with BaseService {
  String get instanceBasePath => '$basePath/workoutInstance';

  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  Future<WorkoutInstance> addInstance(WorkoutInstance instance) async {
    Uri url = Uri.https(authority, '$instanceBasePath');
    Response res = await post(url, body: jsonEncode(instance.toMap()), headers: headers);
    if (res.statusCode < 200 || res.statusCode > 299) {
      throw 'Unable to add instance: statusCode ${res.statusCode}: ${res.body}';
    }
    return WorkoutInstance.fromMap(jsonDecode(res.body));
  }

  Future<WorkoutInstance> updateInstance(WorkoutInstance instance) async {
    Uri url = Uri.https(authority, '$instanceBasePath/${instance.iid}');
    _debouncer.run(() async {
      Response res = await put(url, body: jsonEncode(instance.toMap()), headers: headers);
      if (res.statusCode < 200 || res.statusCode > 299) {
        throw 'Unable to update instance ${instance.iid}: statusCode ${res.statusCode}: ${res.body}';
      }
    });
    return instance;
  }

  Future<List<WorkoutInstance>> getInstancesForWorkout(String wid) async {
    try {
      Uri url = Uri.https(authority, '$instanceBasePath/workout/$wid');
      Response res = await get(url, headers: headers);
      if (res.statusCode < 200 || res.statusCode > 299) {
        throw 'returned status code ${res.statusCode}: ${res.body}';
      }
      List<WorkoutInstance> instances = [];
      jsonDecode(res.body).forEach((map) { 
        instances.add(WorkoutInstance.fromMap(map));
      });
      return instances;
    } catch (e) {
      print('Unable to get workouts for user $wid: $e');
    }
    return [];
  }

  // Future<void> deleteInstancesByWid(String wid) async {
  //   CollectionReference instanceRef =
  //       firestore.collection(workoutInstanceCollection);
  //   await instanceRef.where('wid', isEqualTo: wid).get().then((snapshot) {
  //     var batch = firestore.batch();
  //     snapshot.docs.forEach((doc) {
  //       // For each doc, add a delete operation to the batch
  //       batch.delete(doc.reference);
  //     });
  //     // Commit the batch
  //     return batch.commit();
  //   });
  // }
}
