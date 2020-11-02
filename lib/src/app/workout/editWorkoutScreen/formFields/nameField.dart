import 'package:fitnet/src/app/workout/editWorkoutScreen/workoutChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../editChangeNotifier.dart';

class NameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 250,
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Consumer2<EditChangeNotifier, WorkoutChangeNotifier>(
              builder: (_, editNotifier, workoutNotifier, __) => TextFormField(
                  readOnly: !editNotifier.isEdit,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  initialValue: workoutNotifier.workout.name != null
                      ? workoutNotifier.workout.name
                      : 'Enter Name',
                  onChanged: (value) => workoutNotifier.setName(value)),
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
