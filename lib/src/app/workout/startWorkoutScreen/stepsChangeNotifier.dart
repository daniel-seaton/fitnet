import 'package:fitnet/models/workoutStep.dart';
import 'package:fitnet/models/workoutStepInstance.dart';
import 'package:flutter/cupertino.dart';

class StepsChangeNotifier extends ChangeNotifier {
  List<WorkoutStepInstance> steps;
  WorkoutStepInstance currentStep;
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
