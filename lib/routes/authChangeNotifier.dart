import 'package:fitnet/models/appUser.dart';
import 'package:flutter/material.dart';

class AuthChangeNotifier extends ChangeNotifier {
  AppUser user;
  bool isConfirmed;

  AuthChangeNotifier({@required this.isConfirmed, this.user});

  setUser(AppUser value){
    user = value;
    notifyListeners();
  }

  setIsConfirmed(bool value){
    isConfirmed = value;
    notifyListeners();
  }
}