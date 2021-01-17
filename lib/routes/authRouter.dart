import 'package:fitnet/services/authService.dart';
import 'package:fitnet/routes/auth/authScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../serviceinjector.dart';
import 'home/homeScreen.dart';

class AuthRouter extends StatelessWidget {
  final AuthService authService = injector<AuthService>();

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
        create: (_) => authService
            .getLoggedInUser()
            .map((user) => user != null ? user.uid : null),
        child: Consumer<String>(
            builder: (_, uid, __) => getScreenForAuthStatus(uid)));
  }

  Widget getScreenForAuthStatus(String uid) =>
      uid != null ? HomeScreen(userId: uid) : AuthScreen();
}
