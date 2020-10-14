import 'package:cloud_firestore/cloud_firestore.dart';
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

  AppUser.fromMap(Map<String, dynamic> userMap) {
    credentials = userMap['credentials'];
    firstName = userMap['firstName'];
    lastName = userMap['lastName'];

    if (userMap['city']) city = userMap['city'];
    if (userMap['state']) state = userMap['state'];
    if (userMap['weightLogs']) weightLogs = userMap['weightLogs'];
    if (userMap['height']) height = userMap['height'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'firstName': firstName,
      'lastName': lastName,
      'credentials': credentials,
    };

    if (city != null) map['city'] = city;
    if (state != null) map['state'] = state;
    if (weightLogs.length > 0) map['weightLogs'] = weightLogs;
    if (height != null) map['height'] = height;

    return map;
  }
}
