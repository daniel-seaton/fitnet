import 'package:firebase_core/firebase_core.dart';
import 'package:fitnet/app/tempScreen.dart';
import 'package:fitnet/models/AppUser.dart';
import 'package:fitnet/services/auth-service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/authScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Fitnet());
}

class Fitnet extends StatelessWidget {
  final Future<FirebaseApp> firebaseInit = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
          future: firebaseInit,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Scaffold(
                  appBar: AppBar(
                    title: Text('Fitnet'),
                  ),
                  body: LandingPage());
            } else {
              return LoadingScreen();
            }
          }),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Fitnet')),
        body: Center(child: Text('Loading')));
  }
}

class LandingPage extends StatelessWidget {
  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: auth.getLoggedInUser(),
      child: Consumer<AppUser>(builder: (context, user, _) {
        if (user != null) {
          return TempScreen();
        } else {
          return AuthScreen();
        }
      }),
    );
  }
}
