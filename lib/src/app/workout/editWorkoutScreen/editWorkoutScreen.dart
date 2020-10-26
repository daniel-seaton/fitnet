import 'package:fitnet/models/workout.dart';
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

  EditWorkoutScreen({@required this.workout});

  @override
  Widget build(BuildContext context) {
    WorkoutChangeNotifier workoutChangeNotifier =
        WorkoutChangeNotifier(workout: workout);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Transform.translate(
            offset: Offset(-30, 0),
            child: Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/logo-white-2.png'),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ChangeNotifierProvider.value(
        value: workoutChangeNotifier,
        builder: (context, width) => Form(
          child: ListView(
            children: [
              ...getWorkoutFields(context),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      print('TODO save');
                    },
                    child: Text('Save'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getWorkoutFields(BuildContext context) {
    return workout.toMap().keys.map((field) {
      switch (field) {
        case 'defaultFormat':
          return DefaultFormatField();
        case 'name':
          return NameField();
        case 'scheduled':
          return ScheduledDateField();
        case 'steps':
          return StepListField(
              steps: workout.steps != null ? workout.steps : [],
              defaultFormat: workout.defaultFormat);
        default:
          return Container(height: 0, width: 0);
      }
    }).toList();
  }
}
