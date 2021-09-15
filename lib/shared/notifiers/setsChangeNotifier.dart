import 'dart:async';
import 'dart:collection';

import 'package:fitnet/models/workoutStepInstance.dart';
import 'package:fitnet/shared/notifiers/parentInstanceChangeNotifier.dart';
import 'package:fitnet/utils/timeUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:fitnet/models/set.dart';

import 'instanceChangeNotifier.dart';

class SetsChangeNotifier extends ParentInstanceChangeNotifier<SetBasedStepInstance> {
  List<Set> get sets => currentStep.sets;
  Set get currentSet => sets.firstWhere((s) =>!s.isComplete(), orElse: () => null);
  int get currentSetIndex => sets.indexWhere((s) =>!s.isComplete());


  Timer _timer;
  Duration _timeElapsed = Duration.zero;

  SetsChangeNotifier({@required InstanceChangeNotifier parent}): super(parent);

  @override
  void dispose() {
    if (_timer != null && _timer.isActive) _timer.cancel();
    super.dispose();
  }

  void startRestTimer() {
    if (_timer != null && _timer.isActive) _timer.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _timeElapsed = DateTime.now().difference((currentSet == null ? sets[sets.length - 1] : sets[currentSetIndex - 1]).end);
      notifyListeners();
    });
    notifyListeners();
  }

  void startSetTimer() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }

    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _timeElapsed = DateTime.now().difference(currentSet.start);
      notifyListeners();
    });
    notifyListeners();
  }

  void completeSet() {
    var step = currentStep;
    var index = currentStepIndex;
    currentSet.complete();
    startRestTimer();
    if(currentSet == null) step.complete();
    update(step, index);
  }

  void startSet() {
    currentSet.begin();
    startSetTimer();
    if(!currentStep.isStarted) currentStep.begin();
    update(currentStep);
  }

  void updateWeight(num step) {
    sets.sublist(currentSetIndex).forEach((s) => s.weight+=step);
    update(currentStep);
  }

  void updateActual(num value) {
    currentSet.actual = value;
    update(currentStep);
  }

  String getTimeElapsed() {
    return TimeUtil.getElapsedTimeString(_timeElapsed);
  }
}
