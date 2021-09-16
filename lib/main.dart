//import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
//import 'package:amplify_flutter/amplify.dart';
//import 'package:fitnet/amplifyconfiguration.dart';
import 'package:fitnet/serviceinjector.dart';
import 'package:fitnet/routes/authRouter.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';
import 'package:google_fonts/google_fonts.dart';

// TODO
// implement authentication before each request (verify user is logged in, only allow updates/creates with current id)
// add forgot password
// stop login on incorrect password
// add backend validations & update error messages
// allow user to upload photo to s3
// add backend pagination on list requests

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Cognito.initialize();
 // Amplify.addPlugin(AmplifyAuthCognito());
 // Amplify.configure(amplifyconfig);
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
