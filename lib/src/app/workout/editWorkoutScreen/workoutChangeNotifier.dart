import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutStep.dart';
import 'package:flutter/material.dart';

class WorkoutChangeNotifier extends ChangeNotifier {
  final Workout workout;
  WorkoutChangeNotifier({this.workout});

  void setDefaultFormat(String value) {
    workout.defaultFormat = Format.forType(value);
    notifyListeners();
  }

  void setName(String value) {
    workout.name = value;
    notifyListeners();
  }

  void setScheduled(DateTime value) {
    workout.scheduled = value;
    notifyListeners();
  }

  void addStep(WorkoutStep step, {num index, bool isEdit = false}) {
    if (index == null) {
      workout.steps.add(step);
    } else if (isEdit) {
      workout.steps[index] = step;
    } else {
      workout.steps.insert(index, step);
    }
    notifyListeners();
  }

  WorkoutStep removeStep(num index) {
    WorkoutStep step = workout.steps.removeAt(index);
    notifyListeners();
    return step;
  }
}
