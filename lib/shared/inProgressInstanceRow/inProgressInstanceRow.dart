import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/services/workoutInstanceService.dart';
import 'package:fitnet/shared/progressCircle/progressCircle.dart';
import 'package:fitnet/shared/notifiers/timeElapsedNotifier.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../serviceInjector.dart';
import 'confirmCompletedWorkoutModal/confirmCompletedWorkoutModal.dart';

class InProgressInstanceRow extends StatelessWidget {
  final WorkoutInstanceService instanceService =
      injector<WorkoutInstanceService>();
  final WorkoutInstance instance;
  final double circleSize;
  final bool displayCancelButton;

  InProgressInstanceRow(
      {@required this.instance,
      @required this.circleSize,
      this.displayCancelButton = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: ProgressCircle(
            completionPercentage: instance.percentComplete(),
            completeColor:
                CustomColors.getColorForCompletion(instance.percentComplete()),
            incompleteColor: CustomColors.lightGrey,
            strokeWidth: 5,
            size: circleSize,
            child: Text(
              '${instance.percentComplete()}%',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: ChangeNotifierProvider<TimeElapsedNotifier>.value(
            value: TimeElapsedNotifier(instance.start),
            builder: (ctx, _) => Consumer<TimeElapsedNotifier>(
              builder: (_, notifier, __) => Text(
                'In Progress\nTime Elapsed: ${notifier.getTimeElapsed()}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: displayCancelButton
              ? IconButton(
                  icon: Icon(Icons.highlight_off,
                      color: CustomColors.red, size: 36),
                  onPressed: () => confirmCompleteWorkout(context),
                )
              : Container(height: 0.0, width: 0.0),
        )
      ],
    );
  }

  confirmCompleteWorkout(BuildContext context) async {
    var completeWorkout = await showDialog<bool>(
        context: context, builder: (context) => ConfirmCompleteWorkoutModal());
    if (completeWorkout) {
      instance.end = DateTime.now();
      instance.steps
          .firstWhere((step) => step.isStarted() && !step.isCompleted())
          .end = instance.end;
      await instanceService.updateInstance(instance);
    }
  }
}
