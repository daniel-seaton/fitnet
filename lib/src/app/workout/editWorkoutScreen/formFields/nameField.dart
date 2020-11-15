import 'package:fitnet/src/app/workout/editWorkoutScreen/workoutChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../editChangeNotifier.dart';

class NameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WorkoutChangeNotifier workoutNotifier =
        Provider.of<WorkoutChangeNotifier>(context, listen: false);
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 250,
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Selector2<EditChangeNotifier, WorkoutChangeNotifier,
                Tuple2<bool, String>>(
              selector: (_, edit, workout) =>
                  Tuple2(edit.isEdit, workout.workout.name),
              builder: (_, tuple, __) => TextFormField(
                  readOnly: !tuple.item1,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  initialValue: tuple.item2 ?? 'Enter Name',
                  onChanged: (value) => workoutNotifier.setName(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value == '' || value == 'Enter Name')
                      return '';
                    return null;
                  }),
            ),
          ),
          Consumer<EditChangeNotifier>(
            builder: (_, notifier, __) => !notifier.isEdit
                ? IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => notifier.setIsEdit(true),
                  )
                : Container(height: 0, width: 0),
          ),
        ],
      ),
    );
  }
}
