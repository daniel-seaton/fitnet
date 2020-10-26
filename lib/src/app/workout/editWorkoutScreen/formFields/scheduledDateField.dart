import 'package:fitnet/src/app/workout/editWorkoutScreen/workoutChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScheduledDateField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
          width: MediaQuery.of(context).size.width / 4,
          child: Text('Scheduled:',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyText1),
        ),
        Consumer<WorkoutChangeNotifier>(
          builder: (_, notifier, __) => Container(
            width: MediaQuery.of(context).size.width / 1.5,
            child: InkWell(
              onTap: () async {
                notifier.setScheduled(await showDatePicker(
                  context: context,
                  initialDate: notifier.workout.scheduled,
                  firstDate: DateTime.now().add(Duration(days: -365)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                ));
              },
              child: Container(
                height: 50,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))),
                child: Text(DateFormat.yMd().format(notifier.workout.scheduled),
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
