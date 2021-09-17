
import 'package:flutter/material.dart';

class LoginPageNotifier extends ChangeNotifier {
  String username;
  String password;
  String _err;

  bool get showErrorMessage => _err != null;
  String get errorMessage => _err;

  bool get isValid => username != null && username.isNotEmpty && password != null && password.isNotEmpty;
  
  LoginPageNotifier();

  void setUsername(value) {
    username = value;
    notifyListeners();
  }

  void setPassword(value) {
    password = value;
    notifyListeners();
  }

  void setErrorMessage(String value) {
    _err = value;
    notifyListeners();
  }
}