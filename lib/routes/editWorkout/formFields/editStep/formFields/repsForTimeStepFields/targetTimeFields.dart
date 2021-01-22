import 'package:fitnet/models/workoutStep.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../shared/notifiers/workStepChangeNotifier.dart';

class TargetTimeField extends StatelessWidget {
  final bool isEdit;

  TargetTimeField({@required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 6,
          child: Text('Target Time:',
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
                initialValue: step.targetTime?.toString() ?? '0',
                onChanged: (value) => step.targetTime = num.parse(value)),
          ),
        ),
        Text('seconds',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
