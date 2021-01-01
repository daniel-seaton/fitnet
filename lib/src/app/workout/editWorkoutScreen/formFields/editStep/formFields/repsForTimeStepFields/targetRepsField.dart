import 'package:fitnet/models/workoutStep.dart';
import 'package:fitnet/models/set.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../workStepChangeNotifier.dart';

class TargetRepsField extends StatelessWidget {
  final bool isEdit;

  TargetRepsField({@required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 6,
          child: Text('Reps:',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyText1),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: MediaQuery.of(context).size.width / 6,
          child: Selector<WorkoutStepChangeNotifier, RepsForTimeStep>(
            selector: (_, notifier) => notifier.step as RepsForTimeStep,
            builder: (_, step, __) => TextFormField(
              readOnly: !isEdit,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
              keyboardType: TextInputType.number,
              initialValue: step.targetReps?.toString() ?? '0',
              onChanged: (value) => updateReps(step, num.parse(value)),
            ),
          ),
        ),
      ],
    );
  }

  void updateReps(RepsForTimeStep step, num numReps) {
    step.targetReps = numReps;
  }
}
