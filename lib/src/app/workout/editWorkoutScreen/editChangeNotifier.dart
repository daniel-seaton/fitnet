import 'package:flutter/material.dart';

class EditChangeNotifier extends ChangeNotifier {
  bool isEdit;
  EditChangeNotifier({this.isEdit});

  void setIsEdit(bool value) {
    isEdit = value;
    notifyListeners();
  }
}
