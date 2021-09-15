import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/shared/completedInstanceRow/completedInstanceRow.dart';
import 'package:fitnet/shared/inProgressInstanceRow/inProgressInstanceRow.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';

import 'workoutHistoryStepRow/workoutHistoryStepRow.dart';

class WorkoutHistoryListItem extends StatelessWidget {
  final WorkoutInstance instance;

  WorkoutHistoryListItem({@required this.instance}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: CustomColors.white,
          border: Border.symmetric(
              horizontal: BorderSide(color: CustomColors.lightGrey))),
      child: ExpansionTile(
        trailing: Container(
          height: 0.0,
          width: 0.0,
        ),
        title: Container(
          padding: EdgeInsets.all(5),
          child: instance.isCompleted
              ? CompletedInstanceRow(
                  instance: instance,
                  circleSize: 75,
                )
              : InProgressInstanceRow(instance: instance, circleSize: 75),
        ),
        children: List.generate(
          instance.steps.length,
          (index) => Container(
            color: CustomColors.lightGrey,
            padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
            child: WorkoutHistoryStepRow(stepInstance: instance.steps[index]),
          ),
        ),
      ),
    );
  }
}
