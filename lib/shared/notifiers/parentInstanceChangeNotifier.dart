


import 'package:fitnet/models/workoutStepInstance.dart';
import 'package:fitnet/shared/notifiers/instanceChangeNotifier.dart';
import 'package:flutter/material.dart';

class ParentInstanceChangeNotifier<T extends WorkoutStepInstance> extends ChangeNotifier {
  InstanceChangeNotifier _parent;

  T get currentStep => _parent.currentStep is T ? _parent.currentStep : null;
  num get currentStepIndex => _parent.currentStepIndex;


  ParentInstanceChangeNotifier(this._parent);

  void update(WorkoutStepInstance step, [num index]) {
    _parent.updateStep(step, index);
  }

  void setParent(InstanceChangeNotifier value){
    _parent = value;
    notifyListeners();
  }
}