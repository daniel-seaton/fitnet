

import 'package:fitnet/routes/auth/ConfirmationCodeChangeNotifier.dart';
import 'package:fitnet/routes/auth/authScreenBase.dart';
import 'package:fitnet/routes/authChangeNotifier.dart';
import 'package:fitnet/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../serviceInjector.dart';

class ConfirmationCodeScreen extends StatelessWidget {
  final AuthService authService = injector<AuthService>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConfirmationCodeChangeNotifier>(
      create: (_) => ConfirmationCodeChangeNotifier(),
      builder: (_, __) =>AuthScreenBase(
        child: Consumer2<AuthChangeNotifier, ConfirmationCodeChangeNotifier>(
          builder: (_, auth, notifier, __) => 
            Column(children: [
              Text('A code has been sent to ${auth.email ?? 'your email'}. Please enter that code below and click Confirm', textAlign: TextAlign.center,),
              TextField(
                  decoration: InputDecoration(labelText: 'Code'),
                  onChanged: notifier.setCode
              ),
              Consumer<ConfirmationCodeChangeNotifier>(builder: (_, notifier, __) =>
                ElevatedButton(
                  onPressed: () {
                    authService.confirmSignUp(auth.username, notifier.code).then((success) => 
                      auth.updateIsSignedIn(success)
                    );
                  },
                  child: Text('Confirm'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}