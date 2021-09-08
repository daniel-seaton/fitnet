

import 'package:flutter/material.dart';

class SignUpPageNotifer extends ChangeNotifier {
  String email;
  String username;
  String password;
  String firstName;
  String lastName;
  String code;

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
}