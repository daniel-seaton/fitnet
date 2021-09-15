import 'dart:async';

import 'package:fitnet/utils/timeUtil.dart';
import 'package:flutter/material.dart';

mixin TimerControlMixin on ChangeNotifier {
  Duration _timeElapsed = Duration.zero;
  Timer _timer;
  DateTime _startTime;
  DateTime _endTime;

  @override
  void dispose() {
    if(_timer != null && _timer.isActive) _timer.cancel();
    super.dispose();
  }

  start([DateTime startTime]) {
    _startTime = startTime ?? DateTime.now();
    _timer = _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _timeElapsed = DateTime.now().difference(_startTime);
      notifyListeners();
    });
    notifyListeners();
  }

  end([DateTime endTime]) {
    _timer.cancel();
    _endTime = endTime ?? DateTime.now();
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
