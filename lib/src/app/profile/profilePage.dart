import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../serviceInjector.dart';

class ProfilePage extends StatelessWidget {
  final AuthService authService = injector<AuthService>();
  final UserService userService = injector<UserService>();

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${user.firstName} ${user.lastName}',
          style: TextStyle(fontSize: 24),
        ),
        user.profileImageFilename != null
            ? FutureProvider.value(
                value:
                    userService.getImageDownloadUrl(user.profileImageFilename),
                child: Consumer<String>(
                  builder: (_, downloadUrl, __) => Container(
                      height: 190,
                      width: 190,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(downloadUrl)))),
                ),
              )
            : DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('lib/assets/default-user.jpg'),
              ),
        Transform.translate(
          offset: const Offset(50, -40),
          child: RawMaterialButton(
            shape: CircleBorder(),
            fillColor: Colors.blue,
            onPressed: () => {/* TODO */},
            child: Icon(Icons.add_a_photo_outlined, color: Colors.white),
          ),
        ),
        Text(userHeightAndWeight(user)),
        ElevatedButton(
          onPressed: () => authService.signOut(),
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
