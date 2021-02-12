import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/workoutStepInstance.dart';
import 'package:fitnet/routes/workoutHistory/workoutHistoryStepList/workoutHistoryListItem/workoutHistoryStepRow/repsForTimeMetaDisplay/repsForTimeMetaDisplay.dart';
import 'package:fitnet/routes/workoutHistory/workoutHistoryStepList/workoutHistoryListItem/workoutHistoryStepRow/setBasedStepMetaDisplay/setBasedStepMetaDisplay.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:fitnet/utils/timeUtil.dart';
import 'package:flutter/material.dart';

import 'AMRAPStepMetaDisplay/AMRAPStepMetaDisplay.dart';

class WorkoutHistoryStepRow extends StatelessWidget {
  final WorkoutStepInstance stepInstance;

  WorkoutHistoryStepRow({@required this.stepInstance}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      color: CustomColors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: getStepIcon(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stepInstance.exerciseName,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              this.stepInstance.getHistoryMetaDisplay()
            ],
          ),
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: EdgeInsets.all(3),
            child: Icon(Icons.history, color: CustomColors.grey, size: 28),
          ),
          Text(
            stepInstance.start != null
                ? TimeUtil.getElapsedTimeString(
                    (stepInstance.end ?? DateTime.now())
                        .difference(stepInstance.start))
                : '-:--.--',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }

  Widget getStepIcon() {
    if (stepInstance.isCompleted()) {
      return Icon(Icons.check, color: CustomColors.green, size: 36);
    } else if (stepInstance.isStarted()) {
      return Icon(Icons.directions_run, color: CustomColors.yellow, size: 36);
    } else {
      return Icon(Icons.clear, color: CustomColors.red, size: 36);
    }
  }
}
