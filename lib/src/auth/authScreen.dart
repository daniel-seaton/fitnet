import 'package:fitnet/services/authService.dart';

import '../tabScreen.dart';
import 'loginPage.dart';
import 'signUpPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabScreen(
      upperTabs: [
        Tab(
          child: Text(
            'Log In',
            style: TextStyle(color: Colors.black),
          ),
        ),
        Tab(
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
      tabPages: [LoginPage(), SignUpPage()],
    );
  }
}
