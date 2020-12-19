import 'dart:async';

import 'package:fitnet/utils/timeUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:fitnet/models/set.dart';

class SetsChangeNotifier extends ChangeNotifier {
  Set currentSet;
  num currentIndex;
  final List<Set> sets;

  Timer _timer;
  Duration _timeElapsed = Duration.zero;

  SetsChangeNotifier({@required this.sets, this.currentIndex = 0}) {
    currentSet = sets[currentIndex];
    currentSet.actual = currentSet.goal;
  }

  void finishCurrentSet() {
    _timer.cancel();
    currentSet.end = DateTime.now();
    currentIndex++;
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _timeElapsed = DateTime.now().difference(sets[currentIndex - 1].end);
      notifyListeners();
    });

    if (currentIndex < sets.length) {
      currentSet = sets[currentIndex];
      currentSet.actual = currentSet.goal;
    }
    notifyListeners();
  }

  void startNextSet() {
    if (_timer != null) {
      _timer.cancel();
    }
    currentSet.start = DateTime.now();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _timeElapsed = DateTime.now().difference(currentSet.start);
      notifyListeners();
    });
    notifyListeners();
  }

  void setCurrentActual(num value) {
    currentSet.actual = value;
    notifyListeners();
  }

  void setCurrentWeight(num value) {
    sets.sublist(currentIndex).forEach((s) {
      s.weight = value;
    });
    notifyListeners();
  }

  String getTimeElapsed() {
    return TimeUtil.getElapsedTimeString(_timeElapsed);
  }
}
