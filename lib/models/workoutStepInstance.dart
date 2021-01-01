import 'package:fitnet/models/exercise.dart';
import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/set.dart';
import 'package:fitnet/models/workoutStep.dart';

class WorkoutStepInstanceFactory {
  static WorkoutStepInstance getForStep(String formatType, WorkoutStep step) {
    switch (formatType) {
      case FormatType.SetBased:
        return SetBasedStepInstance.fromStep(step);
      case FormatType.RepsForTime:
        return RepsForTimeStepInstance.fromStep(step);
      case FormatType.AMRAP:
        return AMRAPStepInstance.fromStep(step);
    }
  }

  static WorkoutStepInstance getForMap(
      String formatType, Map<String, dynamic> map) {
    switch (formatType) {
      case FormatType.SetBased:
        return SetBasedStepInstance.fromMap(map);
      case FormatType.RepsForTime:
        return RepsForTimeStepInstance.fromMap(map);
      case FormatType.AMRAP:
        return AMRAPStepInstance.fromMap(map);
    }
  }
}

class WorkoutStepInstance {
  Format format;
  String formatType;
  String exerciseName;
  DateTime start;
  DateTime end;

  WorkoutStepInstance({this.formatType, Exercise exercise}) {
    format = Format.forType(this.formatType);
    exerciseName = exercise.name;
  }

  WorkoutStepInstance.empty() {
    this.exerciseName = 'mock';
  }

  WorkoutStepInstance.fromStep(WorkoutStep step) {
    this.format = step.format;
    this.formatType = step.formatType;
    this.exerciseName = step.exercise.name;
  }

  WorkoutStepInstance.fromMap(Map<String, dynamic> map) {
    formatType = map['formatType'];
    format = Format.forType(this.formatType);
    exerciseName = map['exerciseName'];

    if (map['start'] != null)
      start = DateTime.fromMillisecondsSinceEpoch(map['start'].seconds * 1000);
    if (map['end'] != null)
      start = DateTime.fromMillisecondsSinceEpoch(map['start'].seconds * 1000);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'formatType': formatType,
      'exerciseName': exerciseName,
    };
    if (start != null) map['start'] = start;
    if (end != null) map['end'] = end;
    return map;
  }
}

class SetBasedStepInstance extends WorkoutStepInstance {
  num minimumRest;
  List<Set> sets = [];

  SetBasedStepInstance({this.minimumRest, exercise})
      : super(formatType: FormatType.SetBased, exercise: exercise);

  SetBasedStepInstance.fromStep(SetBasedStep step) : super.fromStep(step) {
    minimumRest = step.minimumRest;
    sets = List.generate(step.targetSets,
        (index) => Set(goal: step.targetReps, weight: step.targetWeight));
  }

  SetBasedStepInstance.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    minimumRest = map['minimumRest'] ?? 0;
    if (map['sets'] != null) {
      List<Set> mappedSets = [];
      map['sets'].forEach((s) => mappedSets.add(Set.fromMap(s)));
      sets = mappedSets;
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['minimumRest'] = minimumRest ?? 0;
    map['sets'] = sets.map((s) => s.toMap()).toList();
    return map;
  }
}

class RepsForTimeStepInstance extends WorkoutStepInstance {
  num targetTime;
  RepsForTimeStepInstance({this.targetTime, Exercise exercise})
      : super(formatType: FormatType.SetBased, exercise: exercise);

  RepsForTimeStepInstance.fromStep(RepsForTimeStep step)
      : super.fromStep(step) {
    targetTime = step.targetTime;
  }

  RepsForTimeStepInstance.fromMap(Map<String, dynamic> map)
      : super.fromMap(map) {
    targetTime = map['targetTime'] ?? 0;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['targetTime'] = targetTime;
    return map;
  }
}

class AMRAPStepInstance extends WorkoutStepInstance {
  num targetTime;
  num targetReps;
  num actualReps = 0;

  AMRAPStepInstance({this.targetTime, this.targetReps, Exercise exercise})
      : super(formatType: FormatType.SetBased, exercise: exercise);

  AMRAPStepInstance.fromStep(AMRAPStep step) : super.fromStep(step) {
    targetTime = step.targetTime;
    targetReps = step.targetReps;
  }

  AMRAPStepInstance.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    targetTime = map['targetTime'] ?? 0;
    targetReps = map['targetReps'] ?? 0;
    actualReps = map['actualReps'] ?? 0;
    print(map);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['targetTime'] = targetTime;
    map['targetReps'] = targetReps;
    if (actualReps > 0) map['actualReps'] = actualReps;
    return map;
  }
}
