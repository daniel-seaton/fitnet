import 'package:fitnet/models/format.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/editChangeNotifier.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/workoutChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class DefaultFormatField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WorkoutChangeNotifier workoutNotifier =
        Provider.of<WorkoutChangeNotifier>(context, listen: false);
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
          child: Selector2<EditChangeNotifier, WorkoutChangeNotifier,
              Tuple2<bool, Format>>(
            selector: (_, edit, workout) =>
                Tuple2(edit.isEdit, workout.workout.defaultFormat),
            builder: (_, tuple, __) => DropdownButtonFormField(
                disabledHint: Text(tuple.item2?.displayValue ?? '',
                    style: Theme.of(context).textTheme.bodyText1),
                value: tuple.item2?.value,
                items: FormatType.getTypes()
                    .map((type) => DropdownMenuItem(
                        child: Text(Format.forType(type).displayValue,
                            style: Theme.of(context).textTheme.bodyText1),
                        value: type))
                    .toList(),
                onChanged: tuple.item1
                    ? (value) => workoutNotifier.setDefaultFormat(value)
                    : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null) return 'Please select a default format';
                  return null;
                }),
          ),
        ),
      ],
    );
  }
}
