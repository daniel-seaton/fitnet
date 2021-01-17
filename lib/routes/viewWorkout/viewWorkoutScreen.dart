import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/routes/startWorkout/startWorkoutScreen.dart';
import 'package:fitnet/services/workoutInstanceService.dart';
import 'package:fitnet/services/workoutService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../serviceInjector.dart';

class ViewWorkoutScreen extends StatelessWidget {
  final WorkoutService workoutService = injector<WorkoutService>();
  final WorkoutInstanceService instanceService =
      injector<WorkoutInstanceService>();
  final Workout workout;

  ViewWorkoutScreen({@required this.workout});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  void startWorkout(BuildContext context) async {
    List<WorkoutInstance> instances =
        await instanceService.getInstancesByWid(workout.wid);
    WorkoutInstance instance = instances.length > 0 ? instances[0] : null;
    if (instance == null || instance.end != null)
      instance = await instanceService.addNewInstance(workout);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => StartWorkoutScreen(instance: instance)));
  }
}
