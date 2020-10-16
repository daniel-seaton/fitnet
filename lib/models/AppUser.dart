import 'package:fitnet/models/weightLog.dart';

class AppUser {
  String uid;
  String firstName;
  String lastName;
  String city;
  String state;
  List<WeightLog> weightLogs = [];
  int height;

  AppUser(this.uid, this.firstName, this.lastName,
      [this.city, this.state, int initialWeight, this.height]) {
    if (initialWeight != null) {
      weightLogs.add(WeightLog(initialWeight));
    }
  }

  AppUser.fromMap(Map<String, dynamic> userMap) {
    uid = userMap['uid'];
    firstName = userMap['firstName'];
    lastName = userMap['lastName'];

    if (userMap['city'] != null) city = userMap['city'];
    if (userMap['state'] != null) state = userMap['state'];
    if (userMap['weightLogs'] != null) weightLogs = userMap['weightLogs'];
    if (userMap['height'] != null) height = userMap['height'];
  }

  AppUser.mock() {
    uid = '1234567';
    firstName = 'Mock';
    lastName = 'User';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'firstName': firstName,
      'lastName': lastName,
      'uid': uid,
    };

    if (city != null) map['city'] = city;
    if (state != null) map['state'] = state;
    if (weightLogs.length > 0) map['weightLogs'] = weightLogs;
    if (height != null) map['height'] = height;

    return map;
  }
}
