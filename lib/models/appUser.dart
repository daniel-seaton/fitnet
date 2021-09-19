import 'dart:io';
import 'dart:typed_data';

import 'package:fitnet/models/weightLog.dart';
import 'package:fitnet/services/userService.dart';

import '../serviceInjector.dart';

class AppUser {
  String uid;
  String firstName;
  String lastName;
  String city;
  String state;
  List<WeightLog> weightLogs = [];
  int height;
  num profileImageVersion;

  UserService service = injector<UserService>();

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
    if (userMap['weightLogs'] != null) {
      List<WeightLog> logs = [];
      userMap['weightLogs'].forEach((log) => logs.add(WeightLog.fromMap(log)));
      weightLogs = logs;
    }
    if (userMap['height'] != null) height = userMap['height'];
    if (userMap['profileImageVersion'] != null) {
      profileImageVersion = userMap['profileImageVersion'];
    } else {
      profileImageVersion = 0;
    }
  }

  AppUser.mock() {
    uid = '1234567';
    firstName = 'Mock';
    lastName = 'User';
    profileImageVersion = 0;
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

  Future<void> setProfileImage(File image) async {
    // can change this to increment profileImageVersion with every upload if we decide we want to store previous pictures
    profileImageVersion = profileImageVersion > 0 ? profileImageVersion : 1;
    await service.uploadImageForUser(this, image);
  } 

  Future<Uint8List> getProfileImage() async => await service.getImageForUser(this);
}
