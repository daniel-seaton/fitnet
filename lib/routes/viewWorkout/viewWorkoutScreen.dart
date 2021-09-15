import 'package:fitnet/routes/editWorkout/editWorkoutScreen.dart';
import 'package:fitnet/routes/viewWorkout/viewWorkoutLatestInstance/viewWorkoutLatestInstance.dart';
import 'package:fitnet/shared/notifiers/listChangeNotifier.dart';
import 'package:fitnet/routes/viewWorkout/viewWorkoutStartButton/viewWorkoutStartButton.dart';
import 'package:fitnet/routes/viewWorkout/viewWorkoutStepList/viewWorkoutStepList.dart';
import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/routes/workoutHistory/workoutHistoryScreen.dart';
import 'package:fitnet/services/workoutInstanceService.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../serviceInjector.dart';

class ViewWorkoutScreen extends StatelessWidget {
  final WorkoutInstanceService instanceService =
      injector<WorkoutInstanceService>();
  final Workout workout;

  ViewWorkoutScreen({@required this.workout});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<List<WorkoutInstance>>(
          initialData: [],
          create: (_) => instanceService.getInstancesForWorkout(workout.wid),
        ),
        ChangeNotifierProxyProvider<List<WorkoutInstance>, ListChangeNotifier<WorkoutInstance>>(
          create: (_) => ListChangeNotifier<WorkoutInstance>(),
          update: (_, list, notifier) {
            notifier.list = list;
            return notifier;
          },
        )
      ],
      builder: (_, __) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            workout.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: CustomColors.white,
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.edit, color: CustomColors.white),
                onPressed: () => editWorkout(context))
          ],
        ),
        body: Selector<ListChangeNotifier<WorkoutInstance>, bool>(
          selector: (_, notifier) => notifier.list.length > 0,
          builder: (_, displayLatestInstance, __) => Column(
            children: [
              Expanded(
                  flex: displayLatestInstance ? 6 : 9,
                  child: ViewWorkoutStepList(steps: workout.steps)),
              displayLatestInstance
                  ? Expanded(
                      flex: 3,
                      child: ViewWorkoutLatestInstance(
                        viewWorkoutHistory: () => viewWorkoutHistory(context),
                      ),
                    )
                  : Container(
                      width: 0.0,
                      height: 0.0,
                    ),
              Expanded(
                  flex: 1,
                  child: ViewWorkoutStartButton(
                    workout: workout,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void viewWorkoutHistory(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WorkoutHistoryScreen(workout: workout)));
  }

  void editWorkout(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditWorkoutScreen(workout: workout)));
  }
}
