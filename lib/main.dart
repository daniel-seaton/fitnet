import 'package:firebase_core/firebase_core.dart';
import 'package:fitnet/src/authRouter.dart';
import 'package:fitnet/src/loadingScreen.dart';
import 'package:flutter/material.dart';

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
          builder: (context, snapshot) =>
              getPageForConnectionState(snapshot.connectionState)),
    );
  }

  Widget getPageForConnectionState(ConnectionState state) =>
      state == ConnectionState.done ? AuthRouter() : LoadingScreen();
}
