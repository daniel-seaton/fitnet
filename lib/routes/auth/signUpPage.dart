import 'package:fitnet/routes/auth/signUpPageNotifier.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/routes/authChangeNotifier.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';
import 'package:provider/provider.dart';

import '../../serviceinjector.dart';

class SignUpPage extends StatelessWidget {
  final AuthService authService = injector<AuthService>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpPageNotifer(),
      builder: (_, __) => 
        Consumer2<AuthChangeNotifier, SignUpPageNotifer>(
          builder: (ctx, auth, notifier, __) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              notifier.showErrorMessage 
                ? Text(notifier.errorMessage, style: TextStyle(color: CustomColors.red),)
                : Container(height: 10.0, width: 0.0,),
              TextField(
                decoration: InputDecoration(labelText: 'Username'),
                onChanged: (String value) {
                  notifier.setUsername(value);
                  auth.setUsername(value);
                }),
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (String value) {
                  notifier.setEmail(value);
                  auth.setEmail(value);
                }),
              TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                onChanged: notifier.setPassword),
              TextField(
                decoration: InputDecoration(labelText: 'First Name'),
                onChanged: notifier.setFirstname),
              TextField(
                decoration: InputDecoration(labelText: 'Last Name'),
                onChanged: notifier.setLastName),
              ElevatedButton(
                onPressed: !notifier.isValid ? null : () {
                  authService.signUp(notifier.username, notifier.email, notifier.password, notifier.firstName, notifier.lastName).then((value) {
                    if (value != null) {
                      auth.setUser(value);
                      auth.notifyRequiresConfirmation();
                    }
                  }, onError: (err) {
                    if(err is InvalidPasswordException || err is UsernameExistsException) notifier.setErrorMessage(err.message);
                  });
                },
                child: Text('Sign up'),
              ),
          ]
        ),
      )
    );
  }
}
