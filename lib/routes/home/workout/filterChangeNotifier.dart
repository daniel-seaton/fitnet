import 'package:flutter/cupertino.dart';

class FilterChangeNotifier extends ChangeNotifier {
  String filter = '';

  FilterChangeNotifier();

  void setFilter(String value) {
    filter = value;
    notifyListeners();
  }
}
