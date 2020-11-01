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

  WorkoutStep.empty() {
    this.exercise = Exercise.empty();
  }

  WorkoutStep.fromMap(Map<String, dynamic> map) {
    formatType = map['formatType'];
    format = Format.forType(this.formatType);
    exercise = Exercise.fromMap(map['exercise']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'formatType': formatType,
      'exercise': exercise.toMap()
    };
    return map;
  }
}

class SetBasedStep extends WorkoutStep {
  num minimumRest;
  List<Set> sets = [];

  SetBasedStep({this.minimumRest, Exercise exercise})
      : super(formatType: FormatType.SetBased, exercise: exercise);

  SetBasedStep.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    minimumRest = map['minimumRest'];
    if (map['sets'] != null) {
      List<Set> mappedSets = [];
      map['sets'].forEach((s) => mappedSets.add(Set.fromMap(s)));
      sets = mappedSets;
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['minimumRest'] = minimumRest;
    map['sets'] = sets.map((s) => s.toMap()).toList();
    return map;
  }
}

class RepsForTimeStep extends WorkoutStep {
  num targetTime;
  num targetReps;
  List<Set> sets = [];

  RepsForTimeStep({this.targetTime, this.targetReps, Exercise exercise})
      : super(formatType: FormatType.SetBased, exercise: exercise);

  RepsForTimeStep.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    targetTime = map['targetTime'];
    targetReps = map['targetReps'];
    if (map['sets'] != null) {
      List<Set> mappedSets = [];
      map['sets'].forEach((s) => mappedSets.add(Set.fromMap(s)));
      sets = mappedSets;
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['targetTime'] = targetTime;
    map['minimumTime'] = targetReps;
    map['sets'] = sets.map((s) => s.toMap()).toList();
    return map;
  }
}

class AMRAPStep extends WorkoutStep {
  num targetTime;
  num targetReps;
  num actualReps = 0;

  AMRAPStep({this.targetTime, this.targetReps, Exercise exercise})
      : super(formatType: FormatType.SetBased, exercise: exercise);

  AMRAPStep.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    targetTime = map['targetTime'];
    targetReps = map['targetReps'];
    if (map['actualReps'] != null) actualReps = map['actualReps'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['targetTime'] = targetTime;
    map['targetReps'] = targetReps;
    map['actualReps'] = actualReps;
    return map;
  }
}
