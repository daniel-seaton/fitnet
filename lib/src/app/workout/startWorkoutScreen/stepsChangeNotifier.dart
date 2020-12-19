import 'package:fitnet/models/workoutStep.dart';
import 'package:flutter/cupertino.dart';

class StepsChangeNotifier extends ChangeNotifier {
  List<WorkoutStep> steps;
  WorkoutStep currentStep;
  num currentIndex;

  StepsChangeNotifier({@required this.steps, this.currentIndex = 0}) {
    currentStep = steps[currentIndex];
    currentStep.start = DateTime.now();
  }

  void nextStep() {
    currentStep.end = DateTime.now();
    currentIndex++;
    if (currentIndex < steps.length) {
      currentStep = steps[currentIndex];
      currentStep.start = DateTime.now();
    }
    notifyListeners();
  }
}
