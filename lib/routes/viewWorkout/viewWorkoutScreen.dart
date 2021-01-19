import 'package:fitnet/routes/viewWorkout/viewWorkoutLatestInstance/viewWorkoutLatestInstance.dart';
import 'package:fitnet/routes/viewWorkout/viewWorkoutStartButton/viewWorkoutStartButton.dart';
import 'package:fitnet/routes/viewWorkout/viewWorkoutStepList/viewWorkoutStepList.dart';
import 'package:fitnet/routes/viewWorkout/viewWorkoutTitle/viewWorkoutTitle.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/models/workoutStep.dart';
import 'package:fitnet/routes/editWorkout/editWorkoutScreen.dart';
import 'package:fitnet/routes/startWorkout/startWorkoutScreen.dart';
import 'package:fitnet/shared/progressCircle.dart';
import 'package:fitnet/shared/timeElapsedNotifier.dart';
import 'package:fitnet/services/workoutInstanceService.dart';
import 'package:fitnet/shared/workoutStepListItem.dart';
import 'package:fitnet/utils/timeUtil.dart';
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
    return StreamProvider<List<WorkoutInstance>>(
      initialData: [],
      create: (_) => instanceService.getInstancesStreamByWid(workout.wid),
      builder: (ctx, _) => Scaffold(
        appBar: AppBar(
          title: ViewWorkoutTitle(workout: workout),
        ),
        body: Column(
          children: [
            Expanded(flex: 6, child: ViewWorkoutStepList(steps: workout.steps)),
            Selector<List<WorkoutInstance>, bool>(
              selector: (_, instances) => instances.length > 0,
              child: Expanded(flex: 3, child: ViewWorkoutLatestInstance()),
              builder: (_, displayLatestInstance, child) =>
                  displayLatestInstance
                      ? child
                      : Container(
                          width: 0.0,
                          height: 0.0,
                        ),
            ),
            Expanded(
                flex: 1,
                child: ViewWorkoutStartButton(
                  workout: workout,
                ))
          ],
        ),
      ),
    );
  }
}
