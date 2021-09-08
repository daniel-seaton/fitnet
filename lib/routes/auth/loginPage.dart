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
                  onChanged: notifier?.setUsername,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  onChanged: notifier?.setPassword,
                ),
                ElevatedButton(
                  onPressed: () {
                    authService.login(notifier.username, notifier.password).then((user) {
                      AuthChangeNotifier authNotifier = Provider.of<AuthChangeNotifier>(context, listen: false);
                      authNotifier.setUser(user);
                      authNotifier.setIsConfirmed(true);
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
