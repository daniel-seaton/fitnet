import 'package:fitnet/models/exercise.dart';
import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/set.dart';

class WorkoutStepFactory {
  static WorkoutStep getForType(String formatType, Map<String, dynamic> map) {
    switch (formatType) {
      case FormatType.SetBased:
        return SetBasedStep.fromMap(map);
      case FormatType.RepsForTime:
        return RepsForTimeStep.fromMap(map);
      case FormatType.AMRAP:
        return AMRAPStep.fromMap(map);
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
  num targetReps;
  num targetWeight;
  num targetSets;

  SetBasedStep({this.minimumRest, this.targetReps, exercise})
      : super(formatType: FormatType.SetBased, exercise: exercise);

  SetBasedStep.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    minimumRest = map['minimumRest'] ?? 0;
    targetReps = map['targetReps'] ?? 0;
    targetWeight = map['targetWieght'] ?? 0;
    targetSets = map['targetSets'] ?? 0;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['minimumRest'] = minimumRest ?? 0;
    map['targetReps'] = targetReps ?? 0;
    map['targetWeight'] = targetWeight ?? 0;
    map['targetSets'] = targetSets ?? 0;
    return map;
  }
}

class RepsForTimeStep extends WorkoutStep {
  num targetTime;
  num targetReps;

  RepsForTimeStep({this.targetTime, this.targetReps, Exercise exercise})
      : super(formatType: FormatType.SetBased, exercise: exercise);

  RepsForTimeStep.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    targetTime = map['targetTime'] ?? 0;
    targetReps = map['targetReps'] ?? 0;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['targetTime'] = targetTime;
    map['targetReps'] = targetReps;
    return map;
  }
}

class AMRAPStep extends WorkoutStep {
  num targetTime;
  num targetReps;

  AMRAPStep({this.targetTime, this.targetReps, Exercise exercise})
      : super(formatType: FormatType.SetBased, exercise: exercise);

  AMRAPStep.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    targetTime = map['targetTime'] ?? 0;
    targetReps = map['targetReps'] ?? 0;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['targetTime'] = targetTime;
    map['targetReps'] = targetReps;
    return map;
  }
}
