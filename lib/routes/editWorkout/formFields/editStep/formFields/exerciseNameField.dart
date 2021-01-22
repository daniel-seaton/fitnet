import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/notifiers/workStepChangeNotifier.dart';

class ExerciseNameField extends StatelessWidget {
  final bool isEdit;

  ExerciseNameField({@required this.isEdit});

  @override
  Widget build(BuildContext context) {
    WorkoutStepChangeNotifier notifier =
        Provider.of<WorkoutStepChangeNotifier>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 6,
          child: Text('Exercise:',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyText1),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: MediaQuery.of(context).size.width / 1.8,
          child: Selector<WorkoutStepChangeNotifier, String>(
            selector: (_, notifier) => notifier.step.exercise != null
                ? notifier.step.exercise.name
                : '',
            builder: (_, exerciseName, __) => TextFormField(
              readOnly: !isEdit,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
              initialValue: exerciseName,
              onChanged: (value) => notifier.setStepName(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value == '')
                  return 'Please enter an exercise name';
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
