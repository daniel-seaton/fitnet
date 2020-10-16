import 'package:fitnet/services/authService.dart';

import 'loginPage.dart';
import 'signUpPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitnet'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              height: 50,
              child: TabBar(tabs: [
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
              ]),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: 500,
              child: TabBarView(children: [
                LoginPage(
                  authService: AuthService(),
                ),
                SignUpPage(
                  authService: AuthService(),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
