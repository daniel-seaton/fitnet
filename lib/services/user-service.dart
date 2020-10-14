import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnet/models/AppUser.dart';
import 'package:fitnet/services/firestore-service.dart';

class UserService {
  final FirestoreService firebaseService = FirestoreService();

  UserService();

  Future<AppUser> getUserForCredentials(UserCredential credentials) async {
    // TODO implement
  }

  Future<AppUser> createNew(
      UserCredential credentials, String firstName, String lastName,
      [String city, String state, int weight, int height]) async {
    AppUser user =
        AppUser(credentials, firstName, lastName, city, state, weight, height);
    return await firebaseService.addUser(user);
  }
}
