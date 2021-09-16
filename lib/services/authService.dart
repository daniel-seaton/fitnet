import 'dart:async';

//import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/userService.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
//import 'package:amplify_flutter/amplify.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../serviceinjector.dart';

class AuthService {
  final UserService userService = injector<UserService>();
  final SharedPreferences local = injector<SharedPreferences>();

  final Uuid uuid = injector<Uuid>();

  Future<AppUser> login(String username, String password) async {
    AppUser user;
    try {
      await signOut();
      SignInResult res = await Cognito.signIn(username, password);
      if (res.signInState == SignInState.DONE) {
        var attrs = await Cognito.getUserAttributes();
        var auth = await Cognito.getTokens();
        await local.setString('jwt', auth.idToken);
        user = await userService.getUser(attrs['custom:uid']);
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
      SignUpResult res = await Cognito.signUp(username, password, {
        'email': email,
        'custom:uid': uid
      });
      
      user = await userService.createNew(uid, firstName,
        lastName, city, state, weight, height);
    } catch (e) {
      print(e);
    }
    return user;
  }

    Future<bool> confirmSignUp(String username, String code) async {
    try {
      SignUpResult confirmRes = await Cognito.confirmSignUp(username, code);
      return confirmRes.confirmationState;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<void> signOut() async {
    await local.remove('jwt');
    await Cognito.signOut();
  }
}
