import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/workoutStep.dart';

class Workout {
  String uid;
  DateTime start;
  DateTime end;
  DateTime scheduled;
  List<WorkoutStep> steps = [];
  FormatType defaultFormat;

  Workout.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    defaultFormat = map['defaultFormat'];
    if (map['start'] != null)
      start = DateTime.fromMillisecondsSinceEpoch(map['start'].seconds * 1000);
    if (map['end'] != null)
      end = DateTime.fromMillisecondsSinceEpoch(map['end'].seconds * 1000);
    if (map['scheduled'] != null)
      scheduled =
          DateTime.fromMillisecondsSinceEpoch(map['scheduled'].seconds * 1000);
    if (map['steps'] != null) {
      const mappedSteps = [];
      map['steps'].forEach((step) => mappedSteps.add(
          WorkoutStepFactory.getForType(
              step['formatType'] ?? defaultFormat, step)));
      steps = mappedSteps;
    }
  }
}
