import 'dart:async';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/userService.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:uuid/uuid.dart';

import '../serviceinjector.dart';

class AuthService {
  final UserService userService = injector<UserService>();
  final Uuid uuid = injector<Uuid>();

  Future<AppUser> login(String username, String password) async {
    AppUser user;
    try {
      await signOut();
      SignInResult res = await Amplify.Auth.signIn(username: username, password: password);
      if (res.isSignedIn) {
        List<AuthUserAttribute> attrs = await Amplify.Auth.fetchUserAttributes();
        String uid = attrs.firstWhere((attr) => attr.userAttributeKey == 'custom:uid').value;
        user = await userService.getUser(uid);
      }
    } catch (e) {
      print('Unable to login: $e');
    }
    return user;
  }

  Future<AppUser> signUp(
      String username, String email, String password, String firstName, String lastName,
      [String city, String state, int weight, int height]) async {
    AppUser user;
    try {
      String uid = uuid.v4();
      SignUpResult res = await Amplify.Auth.signUp(username: username, password: password, options: CognitoSignUpOptions(userAttributes: {
        'email': email,
        'custom:uid': uid,
      }));

      user = await userService.createNew(uid, firstName,
        lastName, city, state, weight, height);
    } catch (e) {
      print(e);
    }
    return user;
  }

    Future<bool> confirmSignUp(String username, String code) async {
    try {
      SignUpResult confirmRes = await Amplify.Auth.confirmSignUp(username: username, confirmationCode: code);
      return confirmRes.isSignUpComplete;
    } catch (e) {
      print(e);
    }
    return false;
  }



  Future<void> signOut() async {
    await Amplify.Auth.signOut();
  }
}
