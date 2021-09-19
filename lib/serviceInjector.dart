// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/services/userService.dart';
import 'package:fitnet/services/workoutInstanceService.dart';
import 'package:fitnet/services/workoutService.dart';

import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

GetIt injector = GetIt.instance;

setupServiceInjector() async {
  injector.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  injector.registerSingleton<Uuid>(Uuid());
  injector.registerSingleton<WorkoutInstanceService>(WorkoutInstanceService());
  injector.registerSingleton<WorkoutService>(WorkoutService());
  injector.registerSingleton<UserService>(UserService());
  injector.registerSingleton<AuthService>(AuthService());
  injector.registerSingleton<ImagePicker>(ImagePicker());
  injector.registerSingleton<ImageCropper>(ImageCropper());
}
