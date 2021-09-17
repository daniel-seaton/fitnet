import 'dart:async';

import 'package:fitnet/models/appUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';

enum AuthState {
  SignedIn,
  ConfirmationRequired,
  SignedOut
}

class AuthChangeNotifier extends ChangeNotifier {
  AppUser user;
  AuthState _state;
  String _username;
  String _email;
  Timer _timer;

  get isSignedIn => _state == AuthState.SignedIn;

  get confirmationRequired => _state == AuthState.ConfirmationRequired;

  get username => _username;
  get email => _email;
  get state => _state;

  AuthChangeNotifier({this.user}){
    _timer = Timer.periodic(Duration(minutes: 1), (timer) async {
      updateIsSignedIn();
    });
    updateIsSignedIn();
  }

  @override 
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  setUser(AppUser value){
    user = value;
    updateIsSignedIn();
  }

  setUsername(String value){
    _username = value;
    notifyListeners();
  }

  setEmail(String value){
    _email = value;
    notifyListeners();
  }

  updateIsSignedIn([bool confirmationCompleted = false]) async {
    if(await Cognito.isSignedIn()){
      _state = AuthState.SignedIn;
    } else if (_state != AuthState.ConfirmationRequired || confirmationCompleted){
      _state = AuthState.SignedOut;
    }
    notifyListeners();
  }

  notifyRequiresConfirmation() {
    _state = AuthState.ConfirmationRequired;
  }
}