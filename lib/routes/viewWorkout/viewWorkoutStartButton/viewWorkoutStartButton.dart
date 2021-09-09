import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/routes/startWorkout/startWorkoutScreen.dart';
import 'package:fitnet/services/workoutInstanceService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../serviceInjector.dart';

class ViewWorkoutStartButton extends StatelessWidget {
  final WorkoutInstanceService instanceService =
      injector<WorkoutInstanceService>();

  final Workout workout;

  ViewWorkoutStartButton({@required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
      height: 100,
      width: 150,
      child: Consumer<List<WorkoutInstance>>(
        builder: (_, instances, __) => ElevatedButton(
          onPressed: () => startWorkout(context, instances),
          child: Text(
            getButtonText(instances),
          ),
        ),
      ),
    );
  }

  String getButtonText(List<WorkoutInstance> instances) {
    return instances.length > 0 && instances[0].end == null
        ? 'Resume Workout'
        : 'Start Workout';
  }

  void startWorkout(
      BuildContext context, List<WorkoutInstance> instances) async {
    WorkoutInstance instance = instances.length > 0 ? instances[0] : null;
    if (instance == null || instance.isCompleted())
      instance = await instanceService.addNewInstance(WorkoutInstance.fromWorkout(workout));
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => StartWorkoutScreen(instance: instance)));
  }
}
