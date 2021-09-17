import 'package:fitnet/routes/auth/signUpPageNotifier.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/routes/authChangeNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../serviceinjector.dart';

class SignUpPage extends StatelessWidget {
  final AuthService authService = injector<AuthService>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpPageNotifer(),
      builder: (_, __) => 
        Consumer<AuthChangeNotifier>(builder: (ctx, notifier, __) => 
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: getSignUpChildren(ctx, notifier)
          ),
        ),
    );
  }

  getSignUpChildren(context, AuthChangeNotifier authNotifier) {
    SignUpPageNotifer readonlyNotifier = Provider.of<SignUpPageNotifer>(context, listen: false);
    return [
      TextField(
          decoration: InputDecoration(labelText: 'Username'),
          onChanged: (String value) {
            readonlyNotifier.setUsername(value);
            authNotifier.setUsername(value);
          }),
      TextField(
          decoration: InputDecoration(labelText: 'Email'),
          onChanged: (String value) {
            readonlyNotifier.setEmail(value);
            authNotifier.setEmail(value);
          }),
      TextField(
          obscureText: true,
          decoration: InputDecoration(labelText: 'Password'),
          onChanged: readonlyNotifier.setPassword),
      TextField(
          decoration: InputDecoration(labelText: 'First Name'),
          onChanged: readonlyNotifier.setFirstname),
      TextField(
          decoration: InputDecoration(labelText: 'Last Name'),
          onChanged: readonlyNotifier.setLastName),
      Consumer<SignUpPageNotifer>(builder: (_, notifier, __) =>
        ElevatedButton(
          onPressed: () {
            authService.signUp(notifier.username, notifier.email, notifier.password, notifier.firstName, notifier.lastName).then((value) {
              if (value != null) {
                authNotifier.setUser(value);
                authNotifier.notifyRequiresConfirmation();
              }
            });
          },
          child: Text('Sign up'),
        ),
      ),
    ];
  }
}
