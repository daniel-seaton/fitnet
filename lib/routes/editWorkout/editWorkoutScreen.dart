import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/routes/startWorkout/startWorkoutScreen.dart';
import 'package:fitnet/routes/editWorkout/workoutChangeNotifier.dart';
import 'package:fitnet/routes/viewWorkout/viewWorkoutScreen.dart';
import 'package:fitnet/services/workoutInstanceService.dart';
import 'package:fitnet/services/workoutService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../serviceInjector.dart';
import 'formFields/defaultFormatField.dart';
import 'formFields/nameField.dart';
import 'formFields/stepListField.dart';

class EditWorkoutScreen extends StatelessWidget {
  final WorkoutService workoutService = injector<WorkoutService>();
  final WorkoutInstanceService instanceService =
      injector<WorkoutInstanceService>();
  final Workout workout;
  final _formKey = GlobalKey<FormState>();

  EditWorkoutScreen({@required this.workout});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ChangeNotifierProvider(
        create: (_) => EditWorkoutChangeNotifier(workout: workout),
        builder: (context, width) => Scaffold(
          appBar: AppBar(centerTitle: true, title: NameField()),
          body: ListView(
            children: [
              DefaultFormatField(),
              StepListField(
                  steps: workout.steps != null ? workout.steps : [],
                  defaultFormat: workout.defaultFormat),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Center(
                  child: Consumer<EditWorkoutChangeNotifier>(
                    builder: (_, notifier, __) => ElevatedButton(
                      onPressed: () => saveWorkout(notifier, context),
                      child: Text(
                        'Save',
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

  void saveWorkout(
      EditWorkoutChangeNotifier notifier, BuildContext context) async {
    if (_formKey.currentState.validate() == true) {
      await workoutService.addOrUpdateWorkout(notifier.workout);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ViewWorkoutScreen(workout: notifier.workout)));
    }
  }
}
