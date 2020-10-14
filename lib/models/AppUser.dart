import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnet/models/WeightLog.dart';

class AppUser {
  UserCredential credentials;
  String firstName;
  String lastName;
  String city;
  String state;
  List<WeightLog> weightLogs = [];
  int height;

  AppUser(this.credentials, this.firstName, this.lastName,
      [this.city, this.state, int initialWeight, this.height]) {
    if (initialWeight != null) {
      weightLogs.add(WeightLog(initialWeight));
    }
  }
}
