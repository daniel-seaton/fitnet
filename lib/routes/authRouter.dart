import 'package:fitnet/routes/auth/authScreen.dart';
import 'package:fitnet/routes/authChangeNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

//import 'home/homeScreen.dart';

class AuthRouter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AuthChangeNotifier(isConfirmed: false),
        child: Consumer<AuthChangeNotifier>(
            builder: (_, notifier, __) => getScreenForAuthStatus(notifier)));
  }

  Widget getScreenForAuthStatus(AuthChangeNotifier notifier) =>
    !notifier.isConfirmed ? AuthScreen() : Container();
}
