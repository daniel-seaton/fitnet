
import 'package:fitnet/models/workoutStepInstance.dart';
import 'package:fitnet/shared/notifiers/parentInstanceChangeNotifier.dart';
import 'package:fitnet/shared/mixins/timerControlMixin.dart';
import 'package:flutter/cupertino.dart';

import 'instanceChangeNotifier.dart';

class AMRAPChangeNotifer extends ParentInstanceChangeNotifier<AMRAPStepInstance> with TimerControlMixin{

  AMRAPChangeNotifer({@required InstanceChangeNotifier parent, DateTime startTime}): super(parent) {
    if(startTime != null) start(startTime);
  }

  setReps(num value){
    currentStep.actualReps = value;
    update(currentStep);
  }

  startStep() {
    currentStep.begin();
    start(currentStep.start);
    update(currentStep);
  }

  completeStep() {
    var step = currentStep;
    print(step.toMap());
    var index = currentStepIndex;
    step.complete();
    end(step.end);
    update(step, index);
  }
}