import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/workoutStep.dart';

class Workout {
  String uid;
  DateTime start;
  DateTime end;
  DateTime scheduled;
  List<WorkoutStep> steps;
  Format defaultFormat;
}
