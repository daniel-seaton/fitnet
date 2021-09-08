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
            children: notifier.user == null
              ? getSignUpChildren(ctx, notifier)
              : getConfirmChildren(ctx, notifier)
          ),
        ),
    );
  }

  getSignUpChildren(context, authNotifier) {
    SignUpPageNotifer readonlyNotifier = Provider.of<SignUpPageNotifer>(context, listen: false);
    return [
      TextField(
          decoration: InputDecoration(labelText: 'Username'),
          onChanged: readonlyNotifier.setUsername),
      TextField(
          decoration: InputDecoration(labelText: 'Email'),
          onChanged: readonlyNotifier.setEmail),
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
            authService.signUp(notifier.username, notifier.email, notifier.password, notifier.firstName, notifier.lastName).then((value) => 
              authNotifier.setUser(value)
            );
          },
          child: Text('Sign up'),
        ),
      ),
    ];
  }

  getConfirmChildren(context, AuthChangeNotifier authNotifier) {
    SignUpPageNotifer readonlyNotifier = Provider.of<SignUpPageNotifer>(context, listen: false); 
    return [
      Text('A code has been sent to ${readonlyNotifier.email}. Please enter that code below and click Confirm', textAlign: TextAlign.center,),
      TextField(
          decoration: InputDecoration(labelText: 'Code'),
          onChanged: readonlyNotifier.setCode),
      Consumer<SignUpPageNotifer>(builder: (_, notifier, __) =>
        ElevatedButton(
          onPressed: () {
            authService.confirmSignUp(notifier.username, notifier.code).then((success) => 
              authNotifier.setIsConfirmed(success)
            );
          },
          child: Text('Confirm'),
        ),
      ),
    ];
  }
}
