
import 'package:flutter/material.dart';

class ConfirmationCodeChangeNotifier extends ChangeNotifier {
  String _code;

  String get code => _code;

  setCode(String value) {
    _code = value;
    notifyListeners();
  }

  ConfirmationCodeChangeNotifier([this._code]);
  
}