import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/services/firestoreService.dart';
import 'package:fitnet/services/userService.dart';
import 'package:get_it/get_it.dart';

import 'services/authService_test.dart';
import 'services/firestoreService_test.dart';
import 'services/userService_test.dart';

GetIt injector = GetIt.instance;

setupTestServiceInjector() {
  injector.registerSingleton<FirebaseFirestore>(MockFirestoreInstance());
  injector.registerSingleton<FirebaseAuth>(MockFirebaseAuth());
  injector.registerSingleton<FirestoreService>(MockFirestoreService());
  injector.registerSingleton<UserService>(MockUserService());
  injector.registerSingleton<AuthService>(MockAuthService());
}
