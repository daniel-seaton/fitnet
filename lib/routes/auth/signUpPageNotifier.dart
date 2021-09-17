

import 'package:flutter/material.dart';

class SignUpPageNotifer extends ChangeNotifier {
  String email;
  String username;
  String password;
  String firstName;
  String lastName;
  String code;

  String _err;

  bool get showErrorMessage => _err != null;
  String get errorMessage => _err;
  bool get isValid => email != null && email.isNotEmpty && username != null && username.isNotEmpty && password != null && password.isNotEmpty;

  setEmail(String value){
    email = value;
    notifyListeners();
  }

  setUsername(String value){
    username = value;
    notifyListeners();
  }

  setFirstname(String value){
    firstName = value;
    notifyListeners();
  }

  setLastName(String value){
    lastName = value;
    notifyListeners();
  }

  setPassword(String value){
    password = value;
    notifyListeners();
  }

  setCode(String value){
    code = value;
    notifyListeners();
  }

  setErrorMessage(String value) {
    _err = value;
    notifyListeners();
  }
}