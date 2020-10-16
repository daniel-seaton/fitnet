import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/authService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../serviceinjector.dart';

class TempScreen extends StatelessWidget {
  final AuthService auth = injector<AuthService>();

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitnet'),
      ),
      body: Center(
        child: Column(children: [
          Text('Hey there ${user.firstName} ${user.lastName}'),
          ElevatedButton(
              child: Text('Sign Out'), onPressed: () => auth.signOut()),
        ]),
      ),
    );
  }
}
