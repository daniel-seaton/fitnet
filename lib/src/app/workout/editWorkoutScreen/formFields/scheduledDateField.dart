import 'package:fitnet/src/app/workout/editWorkoutScreen/workoutChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../editChangeNotifier.dart';

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
        Consumer2<EditChangeNotifier, WorkoutChangeNotifier>(
          builder: (_, editNotifier, workoutNotifier, __) => Container(
            width: MediaQuery.of(context).size.width / 1.5,
            child: InkWell(
              onTap: () async {
                if (!editNotifier.isEdit) return;
                workoutNotifier.setScheduled(await showDatePicker(
                  context: context,
                  initialDate: workoutNotifier.workout.scheduled,
                  firstDate: DateTime.now().add(Duration(days: -365)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                ));
              },
              child: Container(
                height: 50,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))),
                child: TextFormField(
                    initialValue: DateFormat.yMd()
                        .format(workoutNotifier.workout.scheduled),
                    readOnly: true,
                    style: Theme.of(context).textTheme.bodyText1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value == '')
                        return 'Please enter a workout name';
                      return null;
                    }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
