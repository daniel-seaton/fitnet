import 'package:firebase_core/firebase_core.dart';
import 'package:fitnet/serviceinjector.dart';
import 'package:fitnet/src/authRouter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          // TODO add styling for all text, icons, etc.
          // Also should change this to be variable based on if the app is in light or dark mode
          // Might be able to move the logos here too?
          textTheme: TextTheme(
            // Workout List Item Headline
            headline1: GoogleFonts.anton(fontSize: 30, color: Colors.black),
            // Workout List Item Subtitle
            subtitle1: TextStyle(fontSize: 18, color: Colors.grey),
            // Edit Workout Text
            bodyText1: TextStyle(fontSize: 16, color: Colors.black),
            bodyText2: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        home: AuthRouter());
  }
}
