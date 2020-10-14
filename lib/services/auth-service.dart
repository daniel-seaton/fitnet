import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnet/models/AppUser.dart';
import 'package:fitnet/services/user-service.dart';

class AuthService {
  FirebaseAuth firebaseAuth;
  UserService userService;

  AuthService() {
    firebaseAuth = FirebaseAuth.instance;
    userService = UserService();
  }

  Future<AppUser> login(String email, String password) async {
    AppUser user;
    try {
      UserCredential userCredentials = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      user = await userService.getUserForCredentials(userCredentials);
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
      user = await userService.createNew(
          userCredentials, firstName, lastName, city, state, weight, height);
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
}
