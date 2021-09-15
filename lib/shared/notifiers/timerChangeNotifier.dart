
import 'package:fitnet/shared/mixins/timerControlMixin.dart';
import 'package:flutter/cupertino.dart';

class TimerChangeNotifier extends ChangeNotifier with TimerControlMixin {

  TimerChangeNotifier([DateTime startTime]) { 
    if (startTime != null) start(startTime);
  }
}