import 'package:fitnet/models/exercise.dart';
import 'package:fitnet/models/format.dart';

class WorkoutStep {
  Format format;
  FormatType formatType;
  Exercise exercise;

  WorkoutStep({this.formatType, this.exercise}) {
    format = Format.forType(this.formatType);
  }
}

class SetBasedStep extends WorkoutStep {
  num minimumRest;
  List<Set> sets = [];

  SetBasedStep({this.minimumRest, Exercise exercise})
      : super(formatType: FormatType.SetBased, exercise: exercise);
}

class RepsForTimeStep extends WorkoutStep {
  num targetTime;
  num targetReps;
  List<Set> sets = [];

  RepsForTimeStep({this.targetTime, this.targetReps, Exercise exercise})
      : super(formatType: FormatType.SetBased, exercise: exercise);
}

class AMRAPStep extends WorkoutStep {
  num targetTime;
  num targetReps;
  num actualReps = 0;

  AMRAPStep({this.targetTime, this.targetReps, Exercise exercise})
      : super(formatType: FormatType.SetBased, exercise: exercise);
}
