import 'dart:convert';

import 'package:fitnet/models/workout.dart';
import 'package:fitnet/services/baseService.dart';
import 'package:http/http.dart';

class WorkoutService with BaseService {
  final String basePath = 'dev/workout';

  Future<List<Workout>> getWorkoutForUser(String uid) async {
    try {
      Uri url = Uri.https(authority, '$basePath/user/$uid');
      Response res = await get(url, headers: headers);
      if(res.statusCode < 200 || res.statusCode > 299) {
        throw 'returned status code ${res.statusCode}: ${res.body}';
      }
      List<Workout> workouts = [];
      jsonDecode(res.body).forEach((map) { 
        workouts.add(Workout.fromMap(map));
      });
      return workouts;
    } catch (e) {
      print('Unable to get workouts for user $uid: $e');
    }
    return [];
  }

  Future<Workout> addOrUpdateWorkout(Workout workout) async {
    if (workout.wid == null) {
      return await addWorkout(workout);
    } else {
      return await updateWorkout(workout);
    }
  }

  Future<Workout> addWorkout(Workout workout) async {
    Uri url = Uri.https(authority, '$basePath');
    Response res = await post(url, body: jsonEncode(workout.toMap()), headers: headers);
    if(res.statusCode < 200 || res.statusCode > 299) {
      throw 'Unable to add workout: statusCode ${res.statusCode}: ${res.body}';
    }
    return Workout.fromMap(jsonDecode(res.body));
  }

  Future<Workout> updateWorkout(Workout workout) async {
    Uri url = Uri.https(authority, '$basePath/${workout.wid}');
    Response res = await put(url, body: jsonEncode(workout.toMap()), headers: headers);
    if(res.statusCode < 200 || res.statusCode > 299) {
      throw 'Unable to update workout ${workout.wid}: statusCode ${res.statusCode}: ${res.body}';
    }
    return workout;
  }

  deleteWorkout(Workout workout) async {
    Uri url = Uri.https(authority, '$basePath/${workout.wid}');
    Response res = await delete(url, headers: headers);
    if(res.statusCode < 200 || res.statusCode > 299) {
      throw 'Unable to delete workout ${workout.wid}: statusCode ${res.statusCode}: ${res.body}';
    }
  }
}
