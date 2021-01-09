import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutStepInstance.dart';

class WorkoutInstance {
  String iid;
  String wid;
  String uid;
  DateTime start;
  DateTime end;
  List<WorkoutStepInstance> steps = [];

  WorkoutInstance.fromWorkout(Workout workout) {
    wid = workout.wid;
    uid = workout.uid;
    steps = workout.steps
        .map((step) =>
            WorkoutStepInstanceFactory.getForStep(step.formatType, step))
        .toList();
  }

  WorkoutInstance.fromMap(Map<String, dynamic> map) {
    iid = map['iid'];
    wid = map['wid'];
    uid = map['uid'];
    if (map['start'] != null)
      start = DateTime.fromMillisecondsSinceEpoch(map['start'].seconds * 1000);
    if (map['end'] != null)
      end = DateTime.fromMillisecondsSinceEpoch(map['end'].seconds * 1000);
    if (map['steps'] != null) {
      List<WorkoutStepInstance> mappedSteps = [];
      map['steps'].forEach((step) => mappedSteps
          .add(WorkoutStepInstanceFactory.getForMap(step['formatType'], step)));
      steps = mappedSteps;
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'wid': wid,
      'uid': uid,
    };
    if (start != null) map['start'] = start;
    if (end != null) map['end'] = end;
    if (steps != null)
      map['steps'] = steps.map((step) => step.toMap()).toList();
    return map;
  }
}
