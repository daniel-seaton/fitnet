import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/services/baseService.dart';
import 'package:http/http.dart';

class UserService with BaseService {
  String get userBasePath => '$basePath/appUsers';

  Future<AppUser> getUser(String uid) async {
    Uri url = Uri.https(authority, '$userBasePath/$uid');
    Response res = await get(url, headers: headers);
    if(res.statusCode < 200 || res.statusCode > 299){
      throw 'unable to get user with id $uid: statusCode ${res.statusCode}, ${res.body}';
    } else if (res.body == null) {
      throw 'unable to get user with id $uid: user does not exist';
    }
    return AppUser.fromMap(jsonDecode(res.body));
  }

  Future<AppUser> createNew(String uid, String firstName, String lastName,
      [String city, String state, int weight, int height]) async {
    AppUser user =
        AppUser(uid, firstName, lastName, city, state, weight, height);
    try {
      Uri url = Uri.https(authority, userBasePath);
      Response res = await post(url, body: jsonEncode(user.toMap()), headers: headers);
      if (res.statusCode < 200 || res.statusCode > 299) {
        throw 'post failed with status code ${res.statusCode}: ${res.body}';
      }
      return AppUser.fromMap(jsonDecode(res.body));
    } catch (e) {
      print('Unable to add user $user: $e');
      return null;
    }
  }

  Future<String> getImageDownloadUrl(String filename) async {
    return null;
  }

  Future<void> uploadImageForUser(AppUser user, File image) async {
    Uri url = Uri.https(authority, '$userBasePath/${user.uid}/profileImage/${user.profileImageVersion}');
    Response res = await put(url, body: jsonEncode({
      'base64Encoded': base64Encode(await image.readAsBytes())
    }), headers: headers);
    if (res.statusCode < 200 || res.statusCode > 299) {
      print('unable to update proflile image ${user.profileImageVersion} for user ${user.uid}: statusCode ${res.statusCode}, ${res.body}');
    } 
  }

    Future<Uint8List> getImageForUser(AppUser user) async {
    Uri url = Uri.https(authority, '$userBasePath/${user.uid}/profileImage/${user.profileImageVersion}');
    Response res = await get(url, headers: headers);
    if (res.statusCode < 200 || res.statusCode > 299) {
      print('unable to fetch proflile image ${user.profileImageVersion} for user ${user.uid}: statusCode ${res.statusCode}, ${res.body}');
      return null;
    }
    //print(res.body);
    return base64Decode(res.body);
  }
}
