import 'dart:convert';
import 'dart:io';

//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitnet/models/appUser.dart';
import 'package:http/http.dart';

import '../serviceinjector.dart';

class UserService {
  final String authority = '0nbeytk3f4.execute-api.us-east-1.amazonaws.com';
  final String basePath = 'dev/appUsers';
  final Map<String, String> headers = {'Content-type': 'application/json','Accept': 'application/json'};

  Future<AppUser> getUser(String uid) async {
    Uri url = Uri.https(authority, '$basePath/$uid');
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
      Uri url = Uri.https(authority, basePath);
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
    // StorageUploadTask uploadTask = storage.ref().child(user.uid).putFile(image);
    // await uploadTask.onComplete;

    // CollectionReference appUsersRef = firestore.collection(userCollection);
    // List<QueryDocumentSnapshot> userSnapshots = await appUsersRef
    //     .where('uid', isEqualTo: user.uid)
    //     .get()
    //     .then((QuerySnapshot query) {
    //   return query.docs;
    // });
    // if (userSnapshots.length > 1) {
    //   print('Too many users exist for credentials');
    //   throw Exception();
    // } else if (userSnapshots.length == 0) {
    //   print('No user exists for uid ${user.uid}');
    //   return null;
    // }
    // return appUsersRef
    //     .doc(userSnapshots[0].id)
    //     .update({'profileImageVersion': user.profileImageVersion + 1});
    return;
  }
}
