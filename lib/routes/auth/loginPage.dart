import 'package:fitnet/routes/auth/loginPageNotifier.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/routes/authChangeNotifier.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';
import 'package:provider/provider.dart';

import '../../serviceInjector.dart';

class LoginPage extends StatelessWidget {
  final AuthService authService = injector<AuthService>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginPageNotifier(),
      builder: (_, __) => 
        Consumer<LoginPageNotifier>(
          builder: (_, notifier, __) =>
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                notifier.showErrorMessage 
                  ? Text(notifier.errorMessage, style: TextStyle(color: CustomColors.red),)
                  : Container(height: 10.0, width: 0.0,),
                TextField(
                  decoration: InputDecoration(labelText: 'Username'),
                  onChanged: (value) {
                    notifier.setUsername(value);
                    Provider.of<AuthChangeNotifier>(context, listen: false).setUsername(value);
                  }
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  onChanged: notifier.setPassword,
                ),
                ElevatedButton(
                  onPressed: !notifier.isValid ? null : () {
                    AuthChangeNotifier authNotifier = Provider.of<AuthChangeNotifier>(context, listen: false);
                    authService.login(notifier.username, notifier.password, authNotifier.notifyRequiresConfirmation).then((user) {
                      authNotifier.setUser(user);
                    }, onError: (err) {
                      if(err is NotAuthorizedException) notifier.setErrorMessage(err.message);
                    });
                  },
                  child: Text('Log In'),
                ),
              ],
            ),
        ),
      );
  }
}
