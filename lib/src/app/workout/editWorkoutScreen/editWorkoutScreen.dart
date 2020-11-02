import 'package:fitnet/models/workout.dart';
import 'package:fitnet/services/workoutService.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/editChangeNotifier.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/workoutChangeNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../serviceInjector.dart';
import 'formFields/defaultFormatField.dart';
import 'formFields/nameField.dart';
import 'formFields/scheduledDateField.dart';
import 'formFields/stepListField.dart';

class EditWorkoutScreen extends StatelessWidget {
  final WorkoutService workoutService = injector<WorkoutService>();
  final Workout workout;
  final isEdit;
  final _formKey = GlobalKey<FormState>();

  EditWorkoutScreen({@required this.workout, @required this.isEdit});

  @override
  Widget build(BuildContext context) {
    WorkoutChangeNotifier workoutChangeNotifier =
        WorkoutChangeNotifier(workout: workout);
    return Form(
      key: _formKey,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: workoutChangeNotifier),
          ChangeNotifierProvider.value(
              value: EditChangeNotifier(isEdit: isEdit))
        ],
        builder: (context, width) => Scaffold(
          appBar: AppBar(title: NameField()),
          body: ListView(
            children: [
              DefaultFormatField(),
              ScheduledDateField(),
              StepListField(
                  steps: workout.steps != null ? workout.steps : [],
                  defaultFormat: workout.defaultFormat),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Center(
                  child: Consumer2<EditChangeNotifier, WorkoutChangeNotifier>(
                    builder: (_, editNotifier, workoutNotifier, __) =>
                        ElevatedButton(
                      onPressed: () async {
                        if (editNotifier.isEdit &&
                            _formKey.currentState.validate() == true) {
                          await workoutService
                              .addOrUpdateWorkout(workoutNotifier.workout);
                          editNotifier.setIsEdit(false);
                        }
                        // TODO add start workout logic here if isEdit is false, or maybe just add another button with its own on pressed?
                      },
                      child:
                          Text(editNotifier.isEdit ? 'Save' : 'Start Workout'),
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
