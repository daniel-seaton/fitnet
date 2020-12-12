import 'package:fitnet/models/workoutStep.dart';
import 'package:flutter/material.dart';

class WorkoutStepChangeNotifier extends ChangeNotifier {
  WorkoutStep step;
  WorkoutStepChangeNotifier({this.step});

  void setFormat(String value) {
    step.formatType = value;
    step = WorkoutStepFactory.getForType(value, step.toMap());
    notifyListeners();
  }

  void setStepName(String value) {
    step.exercise.name = value;
    notifyListeners();
  }

  void addTag() {
    step.exercise.tags.add('');
    notifyListeners();
  }

  void removeTag(num index) {
    step.exercise.tags.removeAt(index);
    notifyListeners();
  }

  void setTag(String value, int index) {
    step.exercise.tags[index] = value;
    notifyListeners();
  }
}
