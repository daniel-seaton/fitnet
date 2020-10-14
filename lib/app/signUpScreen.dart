import 'package:fitnet/services/auth-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    String firstName;
    String lastName;

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
        TextField(
            decoration: InputDecoration(labelText: 'First Name'),
            onChanged: (String value) => firstName = value),
        TextField(
            decoration: InputDecoration(labelText: 'Last Name'),
            onChanged: (String value) => lastName = value),
        ElevatedButton(
          onPressed: () {
            authService.signUp(email, password, firstName, lastName);
          },
          child: Text('Sign up'),
        ),
      ],
    );
  }
}
