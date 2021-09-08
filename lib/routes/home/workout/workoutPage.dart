import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/models/workout.dart';
import 'package:fitnet/routes/home/workout/workoutListItem/workoutListItem.dart';
import 'package:fitnet/routes/home/workout/workoutSearchBar/workoutSearchBar.dart';
import 'package:fitnet/services/workoutService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../serviceInjector.dart';
import '../../../utils/customColors.dart';
import '../../authChangeNotifier.dart';
import 'createWorkoutButton/createWorkoutButton.dart';
import 'workoutPageChangeNotifier.dart';

class WorkoutPage extends StatelessWidget {
  final WorkoutService workoutService = injector<WorkoutService>();

  WorkoutPage();

  @override
  Widget build(BuildContext context) {
    AuthChangeNotifier authNotifier = Provider.of<AuthChangeNotifier>(context, listen: false);

    return MultiProvider(
      providers: [
        FutureProvider<List<Workout>>.value(
          initialData: [],
          value: authNotifier.user?.uid != null ? workoutService.getWorkoutForUser(authNotifier.user.uid) : Future.value([]), 
        ),
        ChangeNotifierProxyProvider<List<Workout>, WorkoutPageChangeNotifier>(
          create: (_) => WorkoutPageChangeNotifier(),
          update: (_, workouts, notifier) {
            notifier.setWorkouts(workouts);
            return notifier;
          }
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
              child: Consumer<WorkoutPageChangeNotifier>(
                  builder: (_, notifier, __) =>
                      buildFilteredList(notifier.workouts, notifier.filter)),
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
            : CreateWorkoutButton());
  }
}
