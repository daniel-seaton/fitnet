import 'package:fitnet/services/authService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final AuthService authService;

  LoginPage({this.authService});

  @override
  Widget build(BuildContext context) {
    String email;
    String password;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
            decoration: InputDecoration(labelText: 'Email'),
            onChanged: (String value) => email = value),
        TextField(
            decoration: InputDecoration(labelText: 'Password'),
            onChanged: (String value) => password = value),
        ElevatedButton(
          onPressed: () {
            authService.login(email, password);
          },
          child: Text('Log In'),
        ),
      ],
    );
  }
}
