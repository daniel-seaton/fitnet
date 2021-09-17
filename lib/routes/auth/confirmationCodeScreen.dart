

import 'package:fitnet/routes/auth/ConfirmationCodeChangeNotifier.dart';
import 'package:fitnet/routes/authChangeNotifier.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../serviceInjector.dart';

class ConfirmationCodeScreen extends StatelessWidget {
  final AuthService authService = injector<AuthService>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConfirmationCodeChangeNotifier>(
      create: (_) => ConfirmationCodeChangeNotifier(),
      builder: (_, __) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: CustomColors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo-white-2.png'),
                    ),
                  ),
                ),
                Container(
                  height: 500,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                      color: CustomColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  child: Padding(
                    padding: EdgeInsets.all(15),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}