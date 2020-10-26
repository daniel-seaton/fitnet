import 'package:fitnet/models/format.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/workoutChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultFormatField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
          width: MediaQuery.of(context).size.width / 4,
          child: Text('Default Format:',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyText1),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Consumer<WorkoutChangeNotifier>(
            builder: (_, notifier, __) => DropdownButtonFormField(
                value: notifier.workout.defaultFormat.value,
                items: FormatType.getTypes()
                    .map((type) => DropdownMenuItem(
                        child: Text(Format.forType(type).displayValue,
                            style: Theme.of(context).textTheme.bodyText1),
                        value: type))
                    .toList(),
                onChanged: (value) => notifier.setDefaultFormat(value)),
          ),
        ),
      ],
    );
  }
}
