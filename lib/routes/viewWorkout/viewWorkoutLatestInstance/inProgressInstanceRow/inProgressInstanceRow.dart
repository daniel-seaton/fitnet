import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/services/workoutInstanceService.dart';
import 'package:fitnet/shared/progressCircle.dart';
import 'package:fitnet/shared/timeElapsedNotifier.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../serviceInjector.dart';
import 'confirmCompletedWorkoutModal/confirmCompletedWorkoutModal.dart';

class InProgressInstanceRow extends StatelessWidget {
  final WorkoutInstanceService instanceService =
      injector<WorkoutInstanceService>();
  final WorkoutInstance instance;

  InProgressInstanceRow({@required this.instance});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ProgressCircle(
          completionPercentage: instance.percentComplete(),
          completeColor:
              CustomColors.getColorForCompletion(instance.percentComplete()),
          incompleteColor: CustomColors.lightGrey,
          strokeWidth: 5,
          size: 100,
          child: Text(
            '${instance.percentComplete()}%',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        ChangeNotifierProvider<TimeElapsedNotifier>.value(
          value: TimeElapsedNotifier(instance.start),
          builder: (ctx, _) => Consumer<TimeElapsedNotifier>(
            builder: (_, notifier, __) => Text(
              'In Progress\nTime Elapsed: ${notifier.getTimeElapsed()}',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.highlight_off, color: CustomColors.red, size: 36),
          onPressed: () => confirmCompleteWorkout(context),
        )
      ],
    );
  }

  confirmCompleteWorkout(BuildContext context) async {
    var completeWorkout = await showDialog<bool>(
        context: context, builder: (context) => ConfirmCompleteWorkoutModal());
    if (completeWorkout) {
      instance.end = DateTime.now();
      await instanceService.updateInstance(instance);
    }
  }
}
