import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutInstance.dart';
import 'package:flutter/cupertino.dart';

class WorkoutInstancesChangeNotifier extends ChangeNotifier {
  List<WorkoutInstance> instances = [];

  WorkoutInstancesChangeNotifier();

  void setInstances(List<WorkoutInstance> value){
    instances = value;
    notifyListeners();
  }

  void addInstance(WorkoutInstance value){
    instances.insert(0, value);
    notifyListeners();
  }

  void removeInstance(WorkoutInstance value){
    instances.remove(value);
    notifyListeners();
  }

  void updateInstance(WorkoutInstance value){
    num index = instances.indexWhere((w) => w.wid == value.wid);
    if(index >= 0){
      instances[index] = value;
      notifyListeners();
    }
  }
}
