import 'package:fitnet/models/workout.dart';
import 'package:flutter/cupertino.dart';

class WorkoutPageChangeNotifier extends ChangeNotifier {
  String filter = '';
  List<Workout> workouts = [];

  WorkoutPageChangeNotifier();

  void setFilter(String value) {
    filter = value;
    notifyListeners();
  }

  void setWorkouts(List<Workout> value){
    workouts = value;
    notifyListeners();
  }

  void addWorkout(Workout value){
    workouts.insert(0, value);
    notifyListeners();
  }

  void removeWorkout(Workout value){
    workouts.remove(value);
    notifyListeners();
  }

  void updateWorkout(Workout value){
    num index = workouts.indexWhere((w) => w.wid == value.wid);
    if(index >= 0){
      workouts[index] = value;
      notifyListeners();
    }
  }
}
