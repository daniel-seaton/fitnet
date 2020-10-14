import 'loginPage.dart';
import 'signUpPage.dart';
import 'package:fitnet/services/auth-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
            child: TabBarView(children: [LoginPage(), SignUpPage()]),
          ),
        ),
      ),
    );
  }
}
