import 'package:fitnet/models/exercise.dart';
import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/set.dart';

class WorkoutStepFactory {
  static WorkoutStep getForType(String formatType, Map<String, dynamic> map) {
    switch (formatType) {
      case FormatType.SetBased:
        return SetBasedStep.fromMap(map);
        break;
      case FormatType.RepsForTime:
        return RepsForTimeStep.fromMap(map);
        break;
      case FormatType.AMRAP:
        return AMRAPStep.fromMap(map);
        break;
    }
  }
}

class WorkoutStep {
  Format format;
  String formatType;
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

  SetBasedStep.fromMap(Map<String, dynamic> map) {
    formatType = map['formatType'];
    format = Format.forType(this.formatType);
    exercise = Exercise.fromMap(map['exercise']);
    minimumRest = map['minimumRest'];
    if (map['sets'] != null) {
      List<Set> mappedSets = [];
      map['sets'].forEach((s) => mappedSets.add(Set.fromMap(s)));
      sets = mappedSets;
    }
  }
}

class RepsForTimeStep extends WorkoutStep {
  num targetTime;
  num targetReps;
  List<Set> sets = [];

  RepsForTimeStep({this.targetTime, this.targetReps, Exercise exercise})
      : super(formatType: FormatType.SetBased, exercise: exercise);

  RepsForTimeStep.fromMap(Map<String, dynamic> map) {
    formatType = map['formatType'];
    format = Format.forType(this.formatType);
    exercise = Exercise.fromMap(map['exercise']);
    targetTime = map['targetTime'];
    targetReps = map['targetReps'];
    if (map['sets'] != null) {
      List<Set> mappedSets = [];
      map['sets'].forEach((s) => mappedSets.add(Set.fromMap(s)));
      sets = mappedSets;
    }
  }
}

class AMRAPStep extends WorkoutStep {
  num targetTime;
  num targetReps;
  num actualReps = 0;

  AMRAPStep({this.targetTime, this.targetReps, Exercise exercise})
      : super(formatType: FormatType.SetBased, exercise: exercise);

  AMRAPStep.fromMap(Map<String, dynamic> map) {
    formatType = map['formatType'];
    format = Format.forType(this.formatType);
    exercise = Exercise.fromMap(map['exercise']);
    targetTime = map['targetTime'];
    targetReps = map['targetReps'];
    if (map['actualReps'] != null) actualReps = map['actualReps'];
  }
}
