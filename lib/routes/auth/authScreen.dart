import '../../utils/customColors.dart';
import '../../shared/tabScreen/tabScreen.dart';
import 'authScreenBase.dart';
import 'loginPage.dart';
import 'signUpPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthScreenBase(
        child: TabScreen(
          upperTabs: [
            Tab(
              child: Text(
                'Log In',
                style: TextStyle(color: CustomColors.black),
              ),
            ),
            Tab(
              child: Text(
                'Sign Up',
                style: TextStyle(color: CustomColors.black),
              ),
            ),
          ],
          tabPages: [LoginPage(), SignUpPage()],
        ),
    );
  }
}
