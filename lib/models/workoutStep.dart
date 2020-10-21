import 'package:fitnet/models/exercise.dart';
import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/set.dart';

class WorkoutStepFactory {
  WorkoutStepFactory.getForType(
      FormatType formatType, Map<String, dynamic> map) {
    switch (formatType) {
      case FormatType.SetBased:
        break;
      case FormatType.RepsForTime:
        break;
      case FormatType.AMRAP:
        break;
    }
  }
}

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

  SetBasedStep.fromMap(Map<String, dynamic> map) {
    minimumRest = map['minimumRest'];
    if (map['sets'] != null) {
      const mappedSets = [];
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
    targetTime = map['targetTime'];
    targetReps = map['targetReps'];
    if (map['sets'] != null) {
      const mappedSets = [];
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
    targetTime = map['targetTime'];
    targetReps = map['targetReps'];
    if (map['actualReps'] != null) actualReps = map['actualReps'];
  }
}
