import 'package:fitnet/models/workoutStep.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../workStepChangeNotifier.dart';

class TimeField extends StatelessWidget {
  final bool isEdit;

  TimeField({@required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 6,
          child: Text('Time:',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyText1),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: MediaQuery.of(context).size.width / 6,
          child: Selector<WorkoutStepChangeNotifier, AMRAPStep>(
            selector: (_, notifier) => notifier.step as AMRAPStep,
            builder: (_, step, __) => TextFormField(
                readOnly: !isEdit,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
                keyboardType: TextInputType.number,
                initialValue: getMinutes(step).toString(),
                onChanged: (value) =>
                    step.targetTime = num.parse(value) * 60 + getSeconds(step)),
          ),
        ),
        Text(':',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyText1),
        Container(
          width: MediaQuery.of(context).size.width / 6,
          child: Selector<WorkoutStepChangeNotifier, AMRAPStep>(
            selector: (_, notifier) => notifier.step as AMRAPStep,
            builder: (_, step, __) => TextFormField(
                readOnly: !isEdit,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
                keyboardType: TextInputType.number,
                initialValue: getSeconds(step).toString(),
                onChanged: (value) =>
                    step.targetTime = getMinutes(step) * 60 + num.parse(value)),
          ),
        ),
      ],
    );
  }

  num getMinutes(AMRAPStep step) {
    return ((step?.targetTime ?? 0) / 60).floor();
  }

  num getSeconds(AMRAPStep step) {
    return (step?.targetTime ?? 0) % 60;
  }
}
