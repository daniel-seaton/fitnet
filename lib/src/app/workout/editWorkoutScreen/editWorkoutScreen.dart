import 'package:fitnet/models/workout.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/editChangeNotifier.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/workoutChangeNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'formFields/defaultFormatField.dart';
import 'formFields/nameField.dart';
import 'formFields/scheduledDateField.dart';
import 'formFields/stepListField.dart';

class EditWorkoutScreen extends StatelessWidget {
  final Workout workout;
  final isEdit;

  EditWorkoutScreen({@required this.workout, @required this.isEdit});

  @override
  Widget build(BuildContext context) {
    WorkoutChangeNotifier workoutChangeNotifier =
        WorkoutChangeNotifier(workout: workout);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: workoutChangeNotifier),
        ChangeNotifierProvider.value(value: EditChangeNotifier(isEdit: isEdit))
      ],
      builder: (context, width) => Scaffold(
        appBar: AppBar(title: NameField()),
        body: Form(
          child: ListView(
            children: [
              DefaultFormatField(),
              ScheduledDateField(),
              StepListField(
                  steps: workout.steps != null ? workout.steps : [],
                  defaultFormat: workout.defaultFormat),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Center(
                  child: Consumer<EditChangeNotifier>(
                    builder: (_, notifier, __) => ElevatedButton(
                      onPressed: () {
                        if (notifier.isEdit) notifier.setIsEdit(false);
                        print('TODO save');
                      },
                      child: Text(notifier.isEdit ? 'Save' : 'Start Workout'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
