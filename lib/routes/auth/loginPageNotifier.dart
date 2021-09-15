
import 'package:flutter/material.dart';

class LoginPageNotifier extends ChangeNotifier {
  String username;
  String password;

  LoginPageNotifier() {
  }

  void setUsername(value) {
    username = value;
    notifyListeners();
  }

  void setPassword(value) {
    password = value;
    notifyListeners();
  }
}