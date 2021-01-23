import 'package:fitnet/models/workoutStep.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../shared/notifiers/workStepChangeNotifier.dart';

class MinimumRestField extends StatelessWidget {
  final bool isEdit;

  MinimumRestField({@required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 6,
          child: Text('Minimum Rest:',
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
                initialValue: step.minimumRest.toString() ?? '0',
                onChanged: (value) => step.minimumRest = num.parse(value)),
          ),
        ),
        Text('seconds',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
