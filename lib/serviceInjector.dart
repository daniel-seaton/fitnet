import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/services/firestoreService.dart';
import 'package:fitnet/services/userService.dart';

import 'package:get_it/get_it.dart';

GetIt injector = GetIt.instance;

setupServiceInjector() {
  injector.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  injector.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  injector.registerSingleton<FirestoreService>(FirestoreService());
  injector.registerSingleton<UserService>(UserService());
  injector.registerSingleton<AuthService>(AuthService());
}
