import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/userService.dart';

import '../serviceinjector.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = injector<FirebaseAuth>();
  final UserService userService = injector<UserService>();

  Future<AppUser> login(String email, String password) async {
    AppUser user;
    try {
      UserCredential userCredentials = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      user = await userService.getUser(userCredentials.user.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return user;
  }

  Future<AppUser> signUp(
      String email, String password, String firstName, String lastName,
      [String city, String state, int weight, int height]) async {
    AppUser user;
    try {
      UserCredential userCredentials = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      user = await userService.createNew(userCredentials.user.uid, firstName,
          lastName, city, state, weight, height);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Stream<AppUser> getLoggedInUser() {
    return firebaseAuth.authStateChanges().asyncMap((User user) {
      if (user != null) {
        return userService.getUser(user.uid);
      }
      return null;
    });
  }
}
