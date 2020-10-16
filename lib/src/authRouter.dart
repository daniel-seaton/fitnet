import 'package:fitnet/models/AppUser.dart';
import 'package:fitnet/services/auth-service.dart';
import 'package:fitnet/src/app/tempScreen.dart';
import 'package:fitnet/src/auth/authScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AuthRouter extends StatelessWidget {
  final AuthService authService;

  AuthRouter({@required this.authService});

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: authService.getLoggedInUser(),
        child: Consumer<AppUser>(
            builder: (context, user, _) =>
                getScreenForAuthStatus(user != null)));
  }

  Widget getScreenForAuthStatus(bool loggedIn) =>
      loggedIn ? TempScreen() : AuthScreen();
}
