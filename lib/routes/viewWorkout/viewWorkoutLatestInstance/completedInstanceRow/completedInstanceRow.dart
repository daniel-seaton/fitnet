import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/shared/progressCircle.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:fitnet/utils/timeUtil.dart';
import 'package:flutter/material.dart';

class CompletedInstanceRow extends StatelessWidget {
  final WorkoutInstance instance;

  CompletedInstanceRow({@required this.instance});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
      Text(
        'Completed: ${TimeUtil.getTimeBeforeNowString(instance.end)}\nTime Elapsed: ${TimeUtil.getElapsedTimeString(instance.end.difference(instance.start))}',
        style: Theme.of(context).textTheme.subtitle2,
      ),
      IconButton(
        icon: Icon(Icons.more_horiz, color: CustomColors.grey, size: 36),
        onPressed: () => {print('TODO')},
      )
    ]);
  }
}
