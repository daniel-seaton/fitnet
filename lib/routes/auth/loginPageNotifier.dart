
import 'package:flutter/material.dart';

class LoginPageNotifier extends ChangeNotifier {
  String email;
  String password;

  LoginPageNotifier() {
    print("constructor");
  }

  void setEmail(value) {
    email = value;
    print("$value $email $password");
    notifyListeners();
  }

  void setPassword(value) {
    password = value;
    print("$value $email $password");
    notifyListeners();
  }
}