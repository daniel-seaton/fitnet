import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/workoutStep.dart';
import 'package:flutter/material.dart';

class Workout {
  String wid;
  String uid;
  String name;
  List<WorkoutStep> steps = [];
  DateTime created;
  DateTime updated;
  Format defaultFormat;

  Workout({@required this.uid, this.name, this.defaultFormat}) {}

  Workout.mock() {
    wid = '0000000';
    uid = '1234567';
    name = 'mock';
  }

  Workout.fromMap(Map<String, dynamic> map) {
    wid = map['wid'];
    uid = map['uid'];
    name = map['name'];
    defaultFormat = Format.forType(map['defaultFormat']);
    created =
        DateTime.fromMillisecondsSinceEpoch(map['created'].seconds * 1000);
    updated =
        DateTime.fromMillisecondsSinceEpoch(map['updated'].seconds * 1000);

    if (map['steps'] != null) {
      List<WorkoutStep> mappedSteps = [];
      map['steps'].forEach((step) => mappedSteps.add(
          WorkoutStepFactory.getForType(
              step['formatType'] ?? defaultFormat, step)));
      steps = mappedSteps;
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'uid': uid,
      'name': name,
      'created': created != null ? created : DateTime.now(),
      'updated': updated != null ? updated : DateTime.now(),
    };
    if (defaultFormat != null) map['defaultFormat'] = defaultFormat.value;
    if (steps != null)
      map['steps'] = steps.map((step) => step.toMap()).toList();
    return map;
  }
}
