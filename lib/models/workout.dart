import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/workoutStep.dart';
import 'package:flutter/material.dart';

class Workout {
  String wid;
  String uid;
  String name;
  DateTime start;
  DateTime end;
  DateTime scheduled;
  List<WorkoutStep> steps = [];
  Format defaultFormat;

  Workout({@required this.uid, this.name, this.scheduled, this.defaultFormat}) {
    if (scheduled == null) scheduled = DateTime.now();
  }

  Workout.fromMap(Map<String, dynamic> map) {
    wid = map['wid'];
    uid = map['uid'];
    name = map['name'];
    defaultFormat = Format.forType(map['defaultFormat']);
    if (map['start'] != null)
      start = DateTime.fromMillisecondsSinceEpoch(map['start'].seconds * 1000);
    if (map['end'] != null)
      end = DateTime.fromMillisecondsSinceEpoch(map['end'].seconds * 1000);
    if (map['scheduled'] != null)
      scheduled =
          DateTime.fromMillisecondsSinceEpoch(map['scheduled'].seconds * 1000);
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
    };
    if (defaultFormat != null) map['defaultFormat'] = defaultFormat.value;
    if (start != null) map['start'] = start;
    if (end != null) map['end'] = end;
    if (scheduled != null) map['scheduled'] = scheduled;
    if (steps != null)
      map['steps'] = steps.map((step) => step.toMap()).toList();
    return map;
  }
}
