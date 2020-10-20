import 'package:firebase_core/firebase_core.dart';
import 'package:fitnet/serviceinjector.dart';
import 'package:fitnet/src/authRouter.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServiceInjector();
  runApp(Fitnet());
}

class Fitnet extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthRouter());
  }
}
