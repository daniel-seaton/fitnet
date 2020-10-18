import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/src/auth/authScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../serviceinjector.dart';
import 'app/homeScreen.dart';

class AuthRouter extends StatelessWidget {
  final AuthService authService = injector<AuthService>();

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: authService.getLoggedInUser(),
        child: Consumer<AppUser>(
            builder: (context, user, _) =>
                getScreenForAuthStatus(user != null)));
  }

  Widget getScreenForAuthStatus(bool loggedIn) =>
      loggedIn ? HomeScreen() : AuthScreen();
}
