import 'package:fitnet/serviceinjector.dart';
import 'package:fitnet/routes/authRouter.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Cognito.initialize();
  Cognito.signOut();
  await setupServiceInjector();
  runApp(Fitnet());
}

class Fitnet extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: CustomColors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // TODO add styling for all text, icons, etc.
          // Also should change this to be variable based on if the app is in light or dark mode
          // Might be able to move the logos here too?
          textTheme: TextTheme(
            // Workout List Item Headline
            headline1:
                GoogleFonts.anton(fontSize: 30, color: CustomColors.white),

            headline2: TextStyle(fontSize: 24, color: CustomColors.black),
            headline3: TextStyle(fontSize: 24, color: CustomColors.grey),
            // Workout List Item Subtitle
            subtitle1: TextStyle(fontSize: 18, color: CustomColors.black),
            subtitle2: TextStyle(fontSize: 18, color: CustomColors.grey),

            // Edit Workout Text
            bodyText1: TextStyle(fontSize: 16, color: CustomColors.black),
            bodyText2: TextStyle(fontSize: 16, color: CustomColors.grey),
          ),
        ),
        home: AuthRouter());
  }
}
