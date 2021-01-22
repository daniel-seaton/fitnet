import 'dart:async';

import 'package:fitnet/utils/timeUtil.dart';
import 'package:flutter/material.dart';

class TimeElapsedNotifier extends ChangeNotifier {
  Timer _timer;
  Duration _timeElapsed;

  TimeElapsedNotifier(DateTime start) {
    _timeElapsed = DateTime.now().difference(start);
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _timeElapsed = DateTime.now().difference(start);
      notifyListeners();
    });
  }

  String getTimeElapsed() {
    return TimeUtil.getElapsedTimeString(_timeElapsed);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
