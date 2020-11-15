import 'package:fitnet/src/app/workout/editWorkoutScreen/workoutChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../editChangeNotifier.dart';

class ScheduledDateField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WorkoutChangeNotifier workoutNotifier =
        Provider.of<WorkoutChangeNotifier>(context, listen: false);
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
        Selector2<EditChangeNotifier, WorkoutChangeNotifier,
            Tuple2<bool, DateTime>>(
          selector: (_, edit, workout) =>
              Tuple2(edit.isEdit, workout.workout.scheduled),
          builder: (_, tuple, __) => Container(
            width: MediaQuery.of(context).size.width / 1.5,
            child: InkWell(
              onTap: () async {
                if (!tuple.item1) return;
                workoutNotifier.setScheduled(await showDatePicker(
                  context: context,
                  initialDate: tuple.item2,
                  firstDate: DateTime.now().add(Duration(days: -365)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                ));
              },
              child: IgnorePointer(
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  child: Text(
                    DateFormat.yMd().format(tuple.item2),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
