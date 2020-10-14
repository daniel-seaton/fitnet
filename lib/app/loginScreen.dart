import 'package:fitnet/services/auth-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    String email;
    String password;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
        ElevatedButton(
          onPressed: () {
            authService.signUp(email, password, 'Test', 'User');
          },
          child: Text('Sign up'),
        ),
      ],
    );
  }
}
