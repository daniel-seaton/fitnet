import 'package:fitnet/models/workoutStep.dart';
import 'package:fitnet/models/set.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../shared/notifiers/workStepChangeNotifier.dart';

class SetsAndRepsField extends StatelessWidget {
  final bool isEdit;

  SetsAndRepsField({@required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 6,
          child: Text('Sets:',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyText1),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: MediaQuery.of(context).size.width / 6,
          child: Selector<WorkoutStepChangeNotifier, SetBasedStep>(
            selector: (_, notifier) => notifier.step as SetBasedStep,
            builder: (_, step, __) => TextFormField(
              readOnly: !isEdit,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
              keyboardType: TextInputType.number,
              initialValue: step.targetSets.toString(),
              onChanged: (value) => updateSets(step, num.parse(value)),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 6,
          child: Text('Reps:',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyText1),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: MediaQuery.of(context).size.width / 6,
          child: Selector<WorkoutStepChangeNotifier, SetBasedStep>(
            selector: (_, notifier) => notifier.step as SetBasedStep,
            builder: (_, step, __) => TextFormField(
              readOnly: !isEdit,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
              keyboardType: TextInputType.number,
              initialValue: step.targetReps.toString(),
              onChanged: (value) => updateReps(step, num.parse(value)),
            ),
          ),
        ),
      ],
    );
  }

  void updateReps(SetBasedStep step, num numReps) {
    step.targetReps = numReps;
  }

  void updateSets(SetBasedStep step, num numSets) {
    step.targetSets = numSets;
  }
}
