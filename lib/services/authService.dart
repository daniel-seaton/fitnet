import 'dart:async';

import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/userService.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../serviceinjector.dart';

class AuthService {
  final UserService userService = injector<UserService>();
  final SharedPreferences local = injector<SharedPreferences>();

  final Uuid uuid = injector<Uuid>();

  Future<AppUser> login(String username, String password, Function confirmationRequired) async {
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
    } on UserNotConfirmedException catch (e) {
      await Cognito.resendSignUp(username);
      confirmationRequired();
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
      throw e;
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

  Future<ForgotPasswordState> forgotPassword(String username) async {
    ForgotPasswordResult res = await Cognito.forgotPassword(username);
    return res.state;
  }

  Future<ForgotPasswordState> confirmForgotPassword(String username, String code, String newPassword) async {
    ForgotPasswordResult res = await Cognito.confirmForgotPassword(username, newPassword, code);
    return res.state;
  }
}
