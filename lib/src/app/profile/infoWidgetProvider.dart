import 'package:flutter/material.dart';
import 'infoScreenSelector/userInfo/userInfo.dart';
import 'infoScreenSelector/userStats/userStats.dart';

class InfoWidgetProvider extends ChangeNotifier {
  final UserInfo _userInfo = UserInfo();
  final UserStats _userStats = UserStats();

  Widget selectedWidget = UserInfo();

  void select(int key) {
    if (key == 0 && selectedWidget != _userInfo) {
      selectedWidget = _userInfo;
      notifyListeners();
    } else if (key == 1 && selectedWidget != _userStats) {
      selectedWidget = _userStats;
      notifyListeners();
    }
  }

  bool userInfoSelected() => selectedWidget.runtimeType == UserInfo;
}
