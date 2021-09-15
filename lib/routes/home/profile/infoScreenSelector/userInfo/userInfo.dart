import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/routes/authChangeNotifier.dart';
import 'package:fitnet/serviceInjector.dart';
import 'package:fitnet/services/authService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profileImage/profileImage.dart';

class UserInfo extends StatelessWidget {
  final AuthService authService = injector<AuthService>();

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context);
    return Column(
      children: [
        Text(
          '${user.firstName} ${user.lastName}',
          style: TextStyle(fontSize: 24),
        ),
        ProfileImage(),
        Text(userHeightAndWeight(user)),
        ElevatedButton(
          onPressed: () => authService.signOut().then((success) {
            Provider.of<AuthChangeNotifier>(context, listen:false).setUser(null);
            Provider.of<AuthChangeNotifier>(context, listen:false).setIsConfirmed(false);
          }),
          child: Text('Log Out'),
        )
      ],
    );
  }

  String userHeightAndWeight(AppUser user) {
    String ft = '?';
    String inches = '?';
    String weight = '???';
    if (user.height != null) {
      ft = '${(user.height ~/ 12).toString()}';
      inches = '${(user.height % 12).toString()}';
    }

    if (user.weightLogs.length > 0) {
      weight = '${user.weightLogs[0].weight.toString()}';
    }

    return 'Height: $ft\'$inches" Weight: ${weight}lbs';
  }
}
