import 'package:fitnet/models/workoutStep.dart';
import 'package:fitnet/models/set.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../workStepChangeNotifier.dart';

class TargetWeightField extends StatelessWidget {
  final bool isEdit;

  TargetWeightField({@required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 6,
          child: Text('Weight',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyText1),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: MediaQuery.of(context).size.width / 4,
          child: Selector<WorkoutStepChangeNotifier, SetBasedStep>(
            selector: (_, notifier) => notifier.step as SetBasedStep,
            builder: (_, step, __) => TextFormField(
              readOnly: !isEdit,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
              keyboardType: TextInputType.number,
              initialValue: step.targetWeight.toString(),
              onChanged: (value) => updateWeight(step, num.parse(value)),
            ),
          ),
        ),
        Text('lbs',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }

  void updateWeight(SetBasedStep step, num weight) {
    step.targetWeight = weight;
    if (step.sets.length > 0)
      step.sets = List.generate(step.sets.length,
          (_) => Set(goal: step.targetReps, weight: step.targetWeight));
  }
}
