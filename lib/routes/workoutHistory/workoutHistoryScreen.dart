import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/services/workoutInstanceService.dart';
import 'package:fitnet/shared/notifiers/listChangeNotifier.dart';
import 'package:fitnet/shared/notifiers/workoutInstancesChangeNotifier.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../serviceInjector.dart';
import 'workoutHistoryStepList/workoutHistoryStepList.dart';

class WorkoutHistoryScreen extends StatelessWidget {
  final WorkoutInstanceService instanceService =
      injector<WorkoutInstanceService>();
  final Workout workout;

  WorkoutHistoryScreen({@required this.workout});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<List<WorkoutInstance>>.value(
          initialData: [],
          value: instanceService.getInstancesForWorkout(workout.wid),
        ),
        ChangeNotifierProxyProvider<List<WorkoutInstance>, ListChangeNotifier<WorkoutInstance>>(
          create: (_) => ListChangeNotifier<WorkoutInstance>(),
          update: (_, instances, notifier) {
            notifier.list = instances;
            return notifier;
          }
        )
      ],
      builder: (ctx, _) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '${workout.name} History',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: CustomColors.white,
            ),
          ),
        ),
        body: WorkoutHistoryStepList(),
      ),
    );
  }
}
