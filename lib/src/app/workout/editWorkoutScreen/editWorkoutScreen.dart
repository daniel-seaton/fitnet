import 'package:fitnet/models/workout.dart';
import 'package:fitnet/services/workoutInstanceService.dart';
import 'package:fitnet/services/workoutService.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/workoutChangeNotifier.dart';
import 'package:fitnet/src/app/workout/startWorkoutScreen/startWorkoutScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../serviceInjector.dart';
import 'formFields/defaultFormatField.dart';
import 'formFields/nameField.dart';
import 'formFields/stepListField.dart';

class EditWorkoutScreen extends StatelessWidget {
  final WorkoutService workoutService = injector<WorkoutService>();
  final WorkoutInstanceService instanceService =
      injector<WorkoutInstanceService>();
  final Workout workout;
  final isEdit;
  final _formKey = GlobalKey<FormState>();

  EditWorkoutScreen({@required this.workout, @required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ChangeNotifierProvider(
        create: (_) =>
            EditWorkoutChangeNotifier(workout: workout, isEdit: isEdit),
        builder: (context, width) => Scaffold(
          appBar: AppBar(title: NameField()),
          body: ListView(
            children: [
              DefaultFormatField(),
              //  ScheduledDateField(),
              StepListField(
                  steps: workout.steps != null ? workout.steps : [],
                  defaultFormat: workout.defaultFormat),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Center(
                  child: Consumer<EditWorkoutChangeNotifier>(
                    builder: (_, notifier, __) => ElevatedButton(
                      onPressed: () => saveOrStartWorkout(notifier, context),
                      child: Text(
                        getButtonText(notifier.isEdit),
                      ),
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

  String getButtonText(bool isEdit) => isEdit ? 'Save' : 'Start Workout';

  void saveOrStartWorkout(
      EditWorkoutChangeNotifier notifier, BuildContext context) async {
    if (notifier.isEdit && _formKey.currentState.validate() == true) {
      await workoutService.addOrUpdateWorkout(notifier.workout);
      notifier.setIsEdit(false);
    } else if (!notifier.isEdit) {
      await instanceService.addNewInstance(workout);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StartWorkoutScreen(workout: notifier.workout)));
    }
  }
}
