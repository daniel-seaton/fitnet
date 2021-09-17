
import 'package:fitnet/routes/auth/authScreenBase.dart';
import 'package:fitnet/routes/auth/forgotPasswordChangeNotifier.dart';
import 'package:fitnet/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cognito_plugin/models.dart';
import 'package:provider/provider.dart';

import '../../serviceInjector.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final AuthService _authService = injector<AuthService>();

  ForgotPasswordScreen();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordChangeNotifier>(
      create: (_) => ForgotPasswordChangeNotifier(),
      builder: (_, __) => 
        AuthScreenBase(
          child: Consumer<ForgotPasswordChangeNotifier>(
            builder: (_, notifier, __) => 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: getChildrenForState(context, notifier)
              ),
          ),
        )
    );
  }

  List<Widget> getChildrenForState(context, ForgotPasswordChangeNotifier notifier) {
    switch (notifier.state) {
      case ForgotPasswordState.DONE:
        return getDoneChildren(context);
      case ForgotPasswordState.CONFIRMATION_CODE:
        return getEmailSentChildren(context, notifier);
      default:
        return getEnterEmailChildren(context, notifier);
    }
  }

  List<Widget> getEnterEmailChildren(context, ForgotPasswordChangeNotifier notifier) => [
    Text('Please enter the username associated with your account', textAlign: TextAlign.center),
    TextField(decoration: InputDecoration(labelText: 'Username'),
      onChanged: notifier.setUsername
    ),
    ElevatedButton(
      onPressed: () => _authService.forgotPassword(notifier.username).then(notifier.setState),
      child: Text('Done')
    ),
    TextButton(onPressed: Navigator.of(context).pop, child: Text('Cancel'))
  ];

  List<Widget> getEmailSentChildren(context, ForgotPasswordChangeNotifier notifier) => [
    Text('An email containing a confirmation code has been sent to the email associated with that username.', textAlign: TextAlign.center),
    Text('Please enter that code along with a new password and click the button to update your password.', textAlign: TextAlign.center,),
    TextField(decoration: InputDecoration(labelText: 'Confirmation Code'),
      onChanged: notifier.setCode
    ),
    TextField(decoration: InputDecoration(labelText: 'Password'),
      onChanged: notifier.setPassword
    ),
    ElevatedButton(
      onPressed: () => _authService.confirmForgotPassword(notifier.username, notifier.code, notifier.password).then(notifier.setState),
      child: Text('Done')
    ),
    TextButton(onPressed: Navigator.of(context).pop, child: Text('Cancel'))
  ];

  List<Widget> getDoneChildren(context) => [
    Text('Your password has been reset successfully. Click the button below to return to the login screen.', textAlign: TextAlign.center),
    TextButton(onPressed: Navigator.of(context).pop, child: Text('Return to Login'))
  ];
}