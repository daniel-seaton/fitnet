import 'package:fitnet/models/exercise.dart';
import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/set.dart';
import 'package:fitnet/models/workoutStep.dart';
import 'package:fitnet/routes/startWorkout/amrapStepScreen/amrapStepsScreen.dart';
import 'package:fitnet/routes/startWorkout/repsForTimeStepScreen/repsForTimeStepScreen.dart';
import 'package:fitnet/routes/startWorkout/setBasedStepScreen/setBasedStepScreen.dart';
import 'package:fitnet/routes/workoutHistory/workoutHistoryStepList/workoutHistoryListItem/workoutHistoryStepRow/AMRAPStepMetaDisplay/AMRAPStepMetaDisplay.dart';
import 'package:fitnet/routes/workoutHistory/workoutHistoryStepList/workoutHistoryListItem/workoutHistoryStepRow/repsForTimeMetaDisplay/repsForTimeMetaDisplay.dart';
import 'package:fitnet/routes/workoutHistory/workoutHistoryStepList/workoutHistoryListItem/workoutHistoryStepRow/setBasedStepMetaDisplay/setBasedStepMetaDisplay.dart';
import 'package:flutter/material.dart';

abstract class WorkoutStepInstance {
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
    this.exerciseName = step.getDisplayName();
  }

  WorkoutStepInstance.fromMap(Map<String, dynamic> map) {
    formatType = map['formatType'];
    format = Format.forType(this.formatType);
    exerciseName = map['exerciseName'];

    if (map['start'] != null)
      start = DateTime.fromMillisecondsSinceEpoch(map['start']);
    if (map['end'] != null)
      end = DateTime.fromMillisecondsSinceEpoch(map['end']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'formatType': formatType,
      'exerciseName': exerciseName,
    };
    if (start != null) map['start'] = start.millisecondsSinceEpoch;
    if (end != null) map['end'] = end.millisecondsSinceEpoch;
    return map;
  }

  static WorkoutStepInstance forStep(String formatType, WorkoutStep step) {
    switch (formatType) {
      case FormatType.SetBased:
        return SetBasedStepInstance.fromStep(step as SetBasedStep);
      case FormatType.RepsForTime:
        return RepsForTimeStepInstance.fromStep(step as RepsForTimeStep);
      case FormatType.AMRAP:
        return AMRAPStepInstance.fromStep(step as AMRAPStep);
    }
  }

  static WorkoutStepInstance forMap(
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

  double get percentComplete => end != null ? 100 : 0;

  bool get isCompleted => end != null;
  
  bool get isStarted => start != null;

  begin() {
    start = DateTime.now();
  }

  complete() {
    if(isStarted) end = DateTime.now();
  }

  Widget getStartStepScreen();
  Widget getHistoryMetaDisplay();
}

class SetBasedStepInstance extends WorkoutStepInstance {
  num minimumRest;
  List<Set> sets = [];

  SetBasedStepInstance({this.minimumRest, exercise})
      : super(formatType: FormatType.SetBased, exercise: exercise);

  SetBasedStepInstance.fromStep(SetBasedStep step) : super.fromStep(step) {
    minimumRest = step.minimumRest;
    sets = List.generate(step.targetSets,
        (index) => Set(goal: step.targetReps, actual: step.targetReps, weight: step.targetWeight));
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

  @override
  double get percentComplete {
    var percent = 0.0;
    sets.forEach((s) => percent += s.percentComplete());
    return (percent / sets.length * 10).round() / 10;
  }

  Set get currentSet => sets.firstWhere((s) => !s.isComplete(), orElse: () => null);

  @override
  Widget getStartStepScreen() {
    return SetBasedStepScreen();
  }

  @override
  Widget getHistoryMetaDisplay() {
    return SetBasedStepMetaDisplay(stepInstance: this);
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

  @override
  Widget getStartStepScreen() {
    return RepsForTimeStepScreen();
  }

  @override
  Widget getHistoryMetaDisplay() {
    return RepsForTimeMetaDisplay(stepInstance: this);
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
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['targetTime'] = targetTime;
    map['targetReps'] = targetReps;
    if (actualReps > 0) map['actualReps'] = actualReps;
    return map;
  }

  @override
  double get percentComplete {
    if (!isCompleted) {
      return 0;
    }
    return actualReps / targetReps * 100;
  }

  @override
  Widget getStartStepScreen() {
    return AMRAPStepScreen();
  }

  @override
  Widget getHistoryMetaDisplay() {
    return AMRAPStepMetaDisplay(stepInstance: this);
  }
}
