import 'package:fitnet/models/workout.dart';
import 'package:fitnet/services/workoutService.dart';
import 'package:fitnet/src/app/workout/filterChangeNotifier.dart';
import 'package:fitnet/src/app/workout/workoutListItem/workoutListItem.dart';
import 'package:fitnet/src/app/workout/workoutSearchBar/workoutSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../serviceInjector.dart';
import '../../colors.dart';
import 'createWorkoutButton/createWorkoutButton.dart';

class WorkoutPage extends StatelessWidget {
  final WorkoutService workoutService = injector<WorkoutService>();
  final String userId;

  WorkoutPage({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Workout>>.value(
          initialData: [],
          value: workoutService.getWorkoutStreamForUser(userId),
        ),
        ChangeNotifierProvider<FilterChangeNotifier>(
          create: (_) => FilterChangeNotifier(),
        )
      ],
      builder: (_, __) => Container(
        color: CustomColors.lightGrey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WorkoutSearchBar(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 190,
              child: Consumer2<List<Workout>, FilterChangeNotifier>(
                  builder: (_, workouts, notifier, __) =>
                      buildFilteredList(workouts, notifier.filter)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilteredList(List<Workout> workouts, String filter) {
    List<Workout> filteredWorkouts = workouts;
    if (filter != null && filter != '') {
      filteredWorkouts = workouts
          .where((workout) =>
              workout.name.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    }
    return ListView.builder(
        itemCount: filteredWorkouts.length + 1,
        itemBuilder: (context, index) => index < filteredWorkouts.length
            ? WorkoutListItem(workout: filteredWorkouts[index])
            : CreateWorkoutButton(userId: userId));
  }
}
