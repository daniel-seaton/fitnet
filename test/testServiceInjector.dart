import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/services/userService.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import 'mocks.dart';

GetIt injector = GetIt.instance;

setupTestServiceInjector() {
  injector.registerSingleton<FirebaseFirestore>(MockFirestoreInstance2());
  injector.registerSingleton<FirebaseAuth>(MockFirebaseAuth2());
  injector.registerSingleton<FirebaseStorage>(MockFirebaseStorage());
  injector.registerSingleton<UserService>(MockUserService());
  injector.registerSingleton<AuthService>(MockAuthService());
  injector.registerSingleton<ImagePicker>(MockImagePicker());
}
