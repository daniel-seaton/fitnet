import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutStepInstance.dart';

class WorkoutInstance {
  String iid;
  String wid;
  String uid;
  String name;
  DateTime start;
  DateTime end;
  DateTime scheduled;
  List<WorkoutStepInstance> steps = [];
  Format defaultFormat;

  WorkoutInstance.fromWorkout(Workout workout) {
    wid = workout.wid;
    uid = workout.uid;
    name = workout.name;
    steps = workout.steps
        .map((step) =>
            WorkoutStepInstanceFactory.getForStep(step.formatType, step))
        .toList();
  }

  WorkoutInstance.fromMap(Map<String, dynamic> map) {
    iid = map['iid'];
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
      List<WorkoutStepInstance> mappedSteps = [];
      map['steps'].forEach((step) => mappedSteps.add(
          WorkoutStepInstanceFactory.getForStep(
              step['formatType'] ?? defaultFormat, step)));
      steps = mappedSteps;
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'wid': wid,
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
