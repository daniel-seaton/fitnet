import 'package:fitnet/models/workout.dart';
import 'package:fitnet/services/workoutService.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/editWorkoutScreen.dart';
import 'package:fitnet/src/app/workout/workoutListItem/tagsDisplay/tagsDisplayRow.dart';
import 'package:fitnet/src/colors.dart';
import 'package:flutter/material.dart';

import '../../../../serviceInjector.dart';

class WorkoutListItem extends StatelessWidget {
  final Workout workout;
  final WorkoutService workoutService = injector<WorkoutService>();
  WorkoutListItem({@required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(1, 3),
                  blurRadius: 4,
                  color: CustomColors.darkGrey)
            ]),
        child: Column(
          children: [
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () => showEditWorkoutScreen(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    decoration: BoxDecoration(
                      color: CustomColors.blue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6)),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(workout.name,
                            style: Theme.of(context).textTheme.headline1),
                        GestureDetector(
                          child: Icon(Icons.more_horiz,
                              color: CustomColors.white, size: 35.0),
                          onTapDown: (details) =>
                              showWorkoutMenu(context, details.globalPosition),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                        '${workout.defaultFormat.displayValue} ${getDateDisplay()}',
                        style: Theme.of(context).textTheme.subtitle1),
                  ),
                  TagsDisplayRow(steps: this.workout.steps),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showWorkoutMenu(BuildContext context, Offset position) async {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, 0, 0),
      items: [
        PopupMenuItem<String>(child: const Text('Edit'), value: 'Edit'),
        PopupMenuItem<String>(
            child: const Text('Duplicate'), value: 'Duplicate'),
        PopupMenuItem<String>(child: const Text('Delete'), value: 'Delete'),
      ],
    ).then((value) {
      switch (value) {
        case 'Edit':
          showEditWorkoutScreen(context, isEdit: true);
          break;
        case 'Duplicate':
          workoutService.addNewInstance(workout);
          break;
        case 'Delete':
          workoutService.deleteWorkout(workout);
          break;
      }
    });
  }

  showEditWorkoutScreen(BuildContext context, {isEdit = false}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditWorkoutScreen(workout: workout, isEdit: isEdit)));
  }

  getDateDisplay() {
    String date = "";
    if (workout.end != null) {
      date =
          "| Completed: ${workout.end.month}/${workout.end.day}/${workout.end.year}";
    } else if (workout.start != null) {
      date =
          "| Started: ${workout.start.month}/${workout.start.day}/${workout.start.year}";
    } else if (workout.scheduled != null) {
      date =
          "| Scheduled: ${workout.scheduled.month}/${workout.scheduled.day}/${workout.scheduled.year}";
    }
    return date;
  }

  showEditMenu(BuildContext context, Offset offset) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: [
        PopupMenuItem<String>(child: const Text('Edit'), value: 'Edit'),
        PopupMenuItem<String>(child: const Text('Delete'), value: 'Delete'),
      ],
      elevation: 8.0,
    );
  }
}
