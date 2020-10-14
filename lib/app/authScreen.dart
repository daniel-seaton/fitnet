import 'package:fitnet/app/loginScreen.dart';
import 'package:fitnet/app/signUpScreen.dart';
import 'package:fitnet/services/auth-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, children: [
        TabBar(tabs: [
          Tab(child: Text('Log In', style: TextStyle(color: Colors.black))),
          Tab(child: Text('Sign Up', style: TextStyle(color: Colors.black))),
        ]),
        Container(
          height: 500,
          child: TabBarView(children: [LoginScreen(), SignUpScreen()]),
        ),
      ]),
    );
  }
}
