import 'dart:convert';

import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutInstance.dart';
import 'package:http/http.dart';

import '../serviceInjector.dart';

class WorkoutInstanceService {
  final String authority = '0nbeytk3f4.execute-api.us-east-1.amazonaws.com';
  final String basePath = 'dev/workoutInstance';
  final Map<String, String> headers = {'Content-type': 'application/json','Accept': 'application/json'};

  Future<WorkoutInstance> addNewInstance(WorkoutInstance instance) async {
    Uri url = Uri.https(authority, '$basePath');
    Response res = await post(url, body: jsonEncode(instance.toMap()), headers: headers);
    if(res.statusCode < 200 || res.statusCode > 299) {
      throw 'Unable to add instance: statusCode ${res.statusCode}: ${res.body}';
    }
    return WorkoutInstance.fromMap(jsonDecode(res.body));
  }

  Future<WorkoutInstance> updateInstance(WorkoutInstance instance) async {
    Uri url = Uri.https(authority, '$basePath/${instance.iid}');
    Response res = await put(url, body: jsonEncode(instance.toMap()), headers: headers);
    if(res.statusCode < 200 || res.statusCode > 299) {
      throw 'Unable to update instance ${instance.wid}: statusCode ${res.statusCode}: ${res.body}';
    }
    return instance;
  }

  Future<List<WorkoutInstance>> getInstancesForWorkout(String wid) async {
    try {
      Uri url = Uri.https(authority, '$basePath/workout/$wid');
      Response res = await get(url, headers: headers);
      if(res.statusCode < 200 || res.statusCode > 299) {
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
