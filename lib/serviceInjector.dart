import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/services/firebaseStorageService.dart';
import 'package:fitnet/services/firestoreService.dart';
import 'package:fitnet/services/userService.dart';
import 'package:fitnet/services/workoutService.dart';

import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

GetIt injector = GetIt.instance;

setupServiceInjector() {
  injector.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  injector.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  injector.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);
  injector.registerSingleton<FirestoreService>(FirestoreService());
  injector.registerSingleton<FirebaseStorageService>(FirebaseStorageService());
  injector.registerSingleton<WorkoutService>(WorkoutService());
  injector.registerSingleton<UserService>(UserService());
  injector.registerSingleton<AuthService>(AuthService());
  injector.registerSingleton<ImagePicker>(ImagePicker());
}
