import 'package:fitnet/models/AppUser.dart';
import 'package:fitnet/services/auth-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TempScreen extends StatelessWidget {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context);
    return Center(
      child: Column(children: [
        Text('Hey there ${user.firstName} ${user.lastName}'),
        ElevatedButton(
            child: Text('Sign Out'), onPressed: () => auth.signOut()),
      ]),
    );
  }
}
