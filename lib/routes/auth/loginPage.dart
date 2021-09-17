import 'package:fitnet/routes/auth/loginPageNotifier.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/routes/authChangeNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  onPressed: () {
                    AuthChangeNotifier authNotifier = Provider.of<AuthChangeNotifier>(context, listen: false);
                    authService.login(notifier.username, notifier.password, authNotifier.notifyRequiresConfirmation).then((user) {
                      authNotifier.setUser(user);
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
