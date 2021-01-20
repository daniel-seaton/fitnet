import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/shared/progressCircle.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:fitnet/utils/timeUtil.dart';
import 'package:flutter/material.dart';

class CompletedInstanceRow extends StatelessWidget {
  final WorkoutInstance instance;
  final double circleSize;

  CompletedInstanceRow({@required this.instance, @required this.circleSize});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ProgressCircle(
        completionPercentage: instance.percentComplete(),
        completeColor:
            CustomColors.getColorForCompletion(instance.percentComplete()),
        incompleteColor: CustomColors.lightGrey,
        strokeWidth: 5,
        size: this.circleSize,
        child: Text(
          '${instance.percentComplete()}%',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      Text(
        'Completed: ${TimeUtil.getTimeBeforeNowString(instance.end)}\nTime Elapsed: ${TimeUtil.getElapsedTimeString(instance.end.difference(instance.start))}',
        style: Theme.of(context).textTheme.subtitle1,
      ),
    ]);
  }
}
