import 'package:firebase_core/firebase_core.dart';
import 'package:fitnet/app/tempScreen.dart';
import 'package:fitnet/models/AppUser.dart';
import 'package:fitnet/services/auth-service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/loginScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Fitnet());
}

class Fitnet extends StatelessWidget {
  final Future<FirebaseApp> _firebaseInit = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fitnet'),
        ),
        body: FutureBuilder(
            future: _firebaseInit,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return MyHomePage();
              } else {
                return Center(child: Text('Loading'));
              }
            }),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamProvider.value(
        value: auth.getLoggedInUser(),
        child: Consumer<AppUser>(builder: (context, user, _) {
          List<Widget> children = [];
          if (user != null) {
            children.add(TempScreen());
          } else {
            children.add(LoginScreen());
          }

          return Column(
              mainAxisAlignment: MainAxisAlignment.center, children: children);
        }),
      ),
    );
  }
}
