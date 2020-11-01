import 'package:fitnet/models/workout.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/editWorkoutScreen.dart';
import 'package:fitnet/src/app/workout/workoutListItem/tagsDisplay/tagsDisplayRow.dart';
import 'package:flutter/material.dart';

class WorkoutListItem extends StatelessWidget {
  final Workout workout;

  WorkoutListItem({@required this.workout});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatButton(
          onPressed: () => showEditWorkoutScreen(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${workout.name}',
                  style: Theme.of(context).textTheme.headline1),
              Text('${workout.defaultFormat.displayValue} ${getDateDisplay()}',
                  style: Theme.of(context).textTheme.subtitle1),
              TagsDisplayRow(steps: this.workout.steps),
            ],
          ),
        ),
        Divider(color: Colors.grey, thickness: 1.25),
      ],
    );
  }

  showEditWorkoutScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditWorkoutScreen(workout: workout, isEdit: false)));
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
