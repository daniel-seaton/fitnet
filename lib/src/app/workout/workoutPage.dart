import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutStep.dart';
import 'package:fitnet/services/workoutService.dart';
import 'package:fitnet/src/app/workout/workoutListItem/workoutListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../serviceInjector.dart';
import 'createWorkoutButton/createWorkoutButton.dart';

class WorkoutPage extends StatelessWidget {
  final WorkoutService workoutService = injector<WorkoutService>();
  final String userId;

  WorkoutPage({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Workout>>.value(
      initialData: [],
      value: workoutService.getWorkoutStreamForUser(userId),
      child: Consumer<List<Workout>>(
        builder: (_, workouts, __) => ListView.builder(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          itemCount: workouts.length + 1,
          itemBuilder: (context, index) =>
              buildListItem(context, index, workouts),
        ),
      ),
    );
  }

  Widget buildListItem(
      BuildContext context, int index, List<Workout> workouts) {
    if (index < workouts.length) {
      return WorkoutListItem(workout: workouts[index]);
    } else {
      return CreateWorkoutButton(userId: userId);
    }
  }
}
