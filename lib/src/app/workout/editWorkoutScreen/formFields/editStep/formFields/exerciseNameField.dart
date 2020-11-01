import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../workStepChangeNotifier.dart';

class ExerciseNameField extends StatelessWidget {
  final bool isEdit;

  ExerciseNameField({@required this.isEdit});

  @override
  Widget build(BuildContext context) {
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
          child: Consumer<WorkoutStepChangeNotifier>(
            builder: (_, notifier, __) => TextFormField(
                readOnly: !isEdit,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
                initialValue: notifier.step.exercise != null
                    ? notifier.step.exercise.name
                    : '',
                onChanged: (value) => notifier.setStepName(value)),
          ),
        ),
      ],
    );
  }
}
