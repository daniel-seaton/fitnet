import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/shared/completedInstanceRow/completedInstanceRow.dart';
import 'package:fitnet/shared/inProgressInstanceRow/inProgressInstanceRow.dart';
import 'package:fitnet/shared/notifiers/listChangeNotifier.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewWorkoutLatestInstance extends StatelessWidget {
  final Function viewWorkoutHistory;

  ViewWorkoutLatestInstance({@required this.viewWorkoutHistory}) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Selector<ListChangeNotifier<WorkoutInstance>, WorkoutInstance>(
                selector: (_, notifier) => notifier.list[0],
                builder: (_, latestInstance, __) => Text(
                    latestInstance.isCompleted
                        ? 'Last Workout:'
                        : 'In Progress Workout:',
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              FlatButton(
                child: Text(
                  'View History',
                  style: TextStyle(color: CustomColors.blue, fontSize: 18),
                ),
                onPressed: () => viewWorkoutHistory(),
              )
            ],
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
            child: Selector<ListChangeNotifier<WorkoutInstance>, WorkoutInstance>(
                selector: (_, notifier) => notifier.list[0],
                shouldRebuild: (prev, next) => true,
                builder: (_, latestInstance, __) => latestInstance.isCompleted
                    ? CompletedInstanceRow(
                        instance: latestInstance,
                        circleSize: 75,
                      )
                    : InProgressInstanceRow(
                        instance: latestInstance,
                        circleSize: 75,
                        displayCancelButton: true,
                      )),
          ),
        ),
      ],
    );
  }
}
