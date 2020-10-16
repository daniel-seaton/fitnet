import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/firestoreService.dart';

import '../serviceinjector.dart';

class UserService {
  final FirestoreService firestoreService = injector<FirestoreService>();

  UserService();

  Future<AppUser> getUser(String uid) async {
    return await firestoreService.getUser(uid);
  }

  Future<AppUser> createNew(String uid, String firstName, String lastName,
      [String city, String state, int weight, int height]) async {
    AppUser user =
        AppUser(uid, firstName, lastName, city, state, weight, height);
    return await firestoreService.addUser(user);
  }
}
