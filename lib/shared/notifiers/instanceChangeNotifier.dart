
import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/models/workoutStepInstance.dart';
import 'package:fitnet/utils/timeUtil.dart';
import 'package:flutter/cupertino.dart';

class InstanceChangeNotifier extends ChangeNotifier {
  WorkoutInstance _instance;

  InstanceChangeNotifier(this._instance);

  WorkoutInstance get instance => _instance;
  WorkoutStepInstance get currentStep => _instance.currentStep;
  num get currentStepIndex => _instance.currentStepIndex;
  String get currentStepName => currentStep?.exerciseName;

  Widget getCurrentStepScreen() => currentStep.getStartStepScreen();

  updateStep(WorkoutStepInstance step, [num index]) {
    _instance.updateStep(step, index);
    if (_instance.currentStep == null) _instance.complete();
    notifyListeners();
  }

  getTimeElapsed() {
    if(!_instance.isCompleted) return 'Incomplete';
    return TimeUtil.getElapsedTimeString(_instance.end.difference(_instance.start));
  }
}