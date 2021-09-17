

import 'package:flutter/material.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';

class ForgotPasswordChangeNotifier extends ChangeNotifier {

  String _username;
  String _code;
  String _password;
  ForgotPasswordState _state = ForgotPasswordState.UNKNOWN;

  String get username => _username;
  String get code => _code;
  String get password => _password;
  ForgotPasswordState get state => _state;

  ForgotPasswordChangeNotifier();

  setUsername(String value){
    _username = value;
    notifyListeners();
  }

  setCode(String value){
    _code = value;
    notifyListeners();
  }

  setPassword(String value){
    _password = value;
    notifyListeners();
  }

  setState(ForgotPasswordState value){
    _state = value;
    notifyListeners();
  }
}