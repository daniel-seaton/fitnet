import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'completedInstanceRow/completedInstanceRow.dart';
import 'inProgressInstanceRow/inProgressInstanceRow.dart';

class ViewWorkoutLatestInstance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(15, 15, 0, 5),
          child: Selector<List<WorkoutInstance>, WorkoutInstance>(
            selector: (_, instances) => instances[0],
            builder: (_, latestInstance, __) => Text(
                latestInstance.isCompleted()
                    ? 'Last Workout:'
                    : 'In Progress Workout:',
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
              color: CustomColors.white,
              border: Border.all(color: CustomColors.grey, width: 0.5),
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
            padding: EdgeInsets.all(10),
            child: Selector<List<WorkoutInstance>, WorkoutInstance>(
                selector: (_, instances) => instances[0],
                builder: (_, latestInstance, __) => latestInstance.isCompleted()
                    ? CompletedInstanceRow(instance: latestInstance)
                    : InProgressInstanceRow(instance: latestInstance)),
          ),
        ),
      ],
    );
  }
}

class InProgressInstanceDisplay {}
