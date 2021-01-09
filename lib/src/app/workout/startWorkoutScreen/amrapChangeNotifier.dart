import 'dart:async';

import 'package:fitnet/models/workoutStepInstance.dart';
import 'package:fitnet/utils/timeUtil.dart';
import 'package:flutter/material.dart';

class AMRAPChangeNotifier extends ChangeNotifier {
  Duration _timeElapsed = Duration.zero;
  Timer _timer;
  DateTime _startTime;
  DateTime _endTime;

  AMRAPStepInstance step;

  AMRAPChangeNotifier({@required this.step}) {
    step.actualReps = step.targetReps;
  }

  setReps(int value) {
    step.actualReps = value;
    notifyListeners();
  }

  startTimer() {
    _startTime = DateTime.now();
    _timer = _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _timeElapsed = DateTime.now().difference(_startTime);
      notifyListeners();
    });
    notifyListeners();
  }

  endTimer() {
    _timer.cancel();
    _endTime = DateTime.now();
    _timer = _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _timeElapsed = DateTime.now().difference(_endTime);
      notifyListeners();
    });
    notifyListeners();
  }

  started() {
    return _startTime != null;
  }

  completed() {
    return _endTime != null;
  }

  int getTimeElapsedSeconds() {
    return _timeElapsed.inSeconds % 60;
  }

  String getTimeElapsed() {
    return TimeUtil.getElapsedTimeString(_timeElapsed);
  }
}
