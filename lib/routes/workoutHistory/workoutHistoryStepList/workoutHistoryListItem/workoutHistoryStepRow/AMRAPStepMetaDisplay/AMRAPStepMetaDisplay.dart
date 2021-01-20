import 'package:fitnet/models/workoutStepInstance.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';

class AMRAPStepMetaDisplay extends StatelessWidget {
  final AMRAPStepInstance stepInstance;

  AMRAPStepMetaDisplay({@required this.stepInstance}) : super();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.sync, color: CustomColors.grey),
              Icon(Icons.timelapse, color: CustomColors.grey),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${stepInstance.actualReps ?? '--'} / ${stepInstance.targetReps}',
                  style: Theme.of(context).textTheme.subtitle2),
              Text(getTimeDifference(),
                  style: Theme.of(context).textTheme.subtitle2)
            ],
          ),
        ),
      ],
    );
  }

  String getTimeDifference() {
    if (!stepInstance.isCompleted() || !stepInstance.isStarted()) {
      return '-:--.-';
    }
    Duration timeElapsed = stepInstance.end.difference(stepInstance.start);
    num diffInSeconds = timeElapsed.inSeconds - stepInstance.targetTime;
    String diffString = '';
    if (diffInSeconds < 0) {
      diffString += '-';
      diffInSeconds *= -1;
    }
    diffString += '${(diffInSeconds / 60).floor()}';
    diffString += ':${diffInSeconds % 60}';
    return diffString;
  }
}
